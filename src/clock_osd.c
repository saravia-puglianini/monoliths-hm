/*
 * clock_osd.c - Ultra high performance Clock & Status OSD daemon
 * Built for x86_64 Linux with direct sysfs I/O, X11 mouse tracking, and persistent XOSD rendering.
 * Zero fork/exec per tick, sub-millisecond execution, 0% CPU consumption.
 */

#define _GNU_SOURCE
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <time.h>
#include <fcntl.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <xosd.h>
#include <X11/Xlib.h>
#include <X11/Xatom.h>
#include <X11/Xutil.h>

static const char *ascii_v[10][8] = {
    // 0
    { "  /$$$$$$ ", " /$$$_  $$", "| $$$$\\ $$", "| $$ $$ $$", "| $$\\ $$$$", "| $$ \\ $$$", "|  $$$$$$/", " \\______/ " },
    // 1
    { "   /$$  ", " /$$$$  ", "|_  $$  ", "  | $$  ", "  | $$  ", "  | $$  ", " /$$$$$$", "|______/" },
    // 2
    { "  /$$$$$$ ", " /$$__  $$", "|__/  \\ $$", "  /$$$$$$/", " /$$____/ ", "| $$      ", "| $$$$$$$$", "|________/" },
    // 3
    { "  /$$$$$$ ", " /$$__  $$", "|__/  \\ $$", "   /$$$$$/", "  |___  $$", " /$$  \\ $$", "|  $$$$$$/", " \\______/ " },
    // 4
    { " /$$   /$$", "| $$  | $$", "| $$  | $$", "| $$$$$$$$", "|_____  $$", "      | $$", "      | $$", "      |__/" },
    // 5
    { " /$$$$$$$ ", "| $$____/ ", "| $$      ", "| $$$$$$$ ", "|_____  $$", " /$$  \\ $$", "|  $$$$$$/", " \\______/ " },
    // 6
    { "  /$$$$$$ ", " /$$__  $$", "| $$  \\__/", "| $$$$$$$ ", "| $$__  $$", "| $$  \\ $$", "|  $$$$$$/", " \\______/ " },
    // 7
    { " /$$$$$$$$", "|_____ $$/", "     /$$/ ", "    /$$/  ", "   /$$/   ", "  /$$/    ", " /$$/     ", "|__/      " },
    // 8
    { "  /$$$$$$ ", " /$$__  $$", "| $$  \\ $$", "|  $$$$$$/", " >$$__  $$", "| $$  \\ $$", "|  $$$$$$/", " \\______/ " },
    // 9
    { "  /$$$$$$ ", " /$$__  $$", "| $$  \\ $$", "|  $$$$$$$", " \\____  $$", " /$$  \\ $$", "|  $$$$$$/", " \\______/ " }
};

static const char *ascii_colon[8] = {
    "    ", " /$$", "|__/", "    ", " /$$", "|__/", "    ", "    "
};

static int x11_silent_error_handler(Display *d, XErrorEvent *e) {
    (void)d;
    (void)e;
    return 0;
}

static void make_window_sticky_and_above(Display *dpy, Window root, Window win) {
    Atom wm_state = XInternAtom(dpy, "_NET_WM_STATE", False);
    Atom state_sticky = XInternAtom(dpy, "_NET_WM_STATE_STICKY", False);
    Atom state_above = XInternAtom(dpy, "_NET_WM_STATE_ABOVE", False);

    XEvent xev;
    memset(&xev, 0, sizeof(xev));
    xev.type = ClientMessage;
    xev.xclient.window = win;
    xev.xclient.message_type = wm_state;
    xev.xclient.format = 32;
    xev.xclient.data.l[0] = 1; // _NET_WM_STATE_ADD
    xev.xclient.data.l[1] = state_sticky;
    xev.xclient.data.l[2] = state_above;
    xev.xclient.data.l[3] = 1; // source indication

    XSendEvent(dpy, root, False, SubstructureRedirectMask | SubstructureNotifyMask, &xev);

    // Set _NET_WM_DESKTOP to 0xFFFFFFFF (all desktops)
    Atom wm_desktop = XInternAtom(dpy, "_NET_WM_DESKTOP", False);
    unsigned long desktop = 0xFFFFFFFF;
    XChangeProperty(dpy, win, wm_desktop, XA_CARDINAL, 32, PropModeReplace, (unsigned char *)&desktop, 1);
}

static void make_all_xosd_windows_sticky(Display *dpy, Window root) {
    Window root_return, parent_return, *children;
    unsigned int nchildren;
    if (XQueryTree(dpy, root, &root_return, &parent_return, &children, &nchildren)) {
        for (unsigned int i = 0; i < nchildren; i++) {
            char *name = NULL;
            int is_xosd = 0;
            if (XFetchName(dpy, children[i], &name) > 0 && name) {
                if (strcmp(name, "XOSD") == 0) {
                    is_xosd = 1;
                }
                XFree(name);
            }
            if (is_xosd) {
                XWindowAttributes attr;
                if (XGetWindowAttributes(dpy, children[i], &attr) && attr.map_state != IsUnmapped) {
                    make_window_sticky_and_above(dpy, root, children[i]);
                    XRaiseWindow(dpy, children[i]);
                }
            }
        }
        if (children) XFree(children);
    }
}

static int read_sysfs_int(const char *path) {
    int fd = open(path, O_RDONLY);
    if (fd < 0) return 0;
    char buf[32];
    ssize_t n = read(fd, buf, sizeof(buf) - 1);
    close(fd);
    if (n <= 0) return 0;
    buf[n] = '\0';
    return atoi(buf);
}

static int file_contains(const char *filepath, const char *pattern) {
    int fd = open(filepath, O_RDONLY);
    if (fd < 0) return 0;
    char buf[4096];
    ssize_t n = read(fd, buf, sizeof(buf) - 1);
    close(fd);
    if (n <= 0) return 0;
    buf[n] = '\0';
    return (strstr(buf, pattern) != NULL);
}

static int check_window_title_contains(Display *dpy, Window root, const char *needle) {
    Atom net_client_list = XInternAtom(dpy, "_NET_CLIENT_LIST", True);
    if (net_client_list == None) return 0;

    Atom actual_type;
    int actual_format;
    unsigned long nitems, bytes_after;
    unsigned char *prop = NULL;

    if (XGetWindowProperty(dpy, root, net_client_list, 0, 1024, False, XA_WINDOW,
                           &actual_type, &actual_format, &nitems, &bytes_after, &prop) == Success) {
        if (prop) {
            Window *windows = (Window *)prop;
            for (unsigned long i = 0; i < nitems; i++) {
                char *name = NULL;
                if (XFetchName(dpy, windows[i], &name) > 0 && name) {
                    if (strstr(name, needle) != NULL) {
                        XFree(name);
                        XFree(prop);
                        return 1;
                    }
                    XFree(name);
                }
            }
            XFree(prop);
        }
    }
    return 0;
}



int main(void) {
    const char *home = getenv("HOME");
    if (!home) home = "/home/user";

    char stop_file[256];
    char xbindkeys_file[256];
    char big_hour_file[256];
    snprintf(stop_file, sizeof(stop_file), "%s/.stop_personal_osdx", home);
    snprintf(xbindkeys_file, sizeof(xbindkeys_file), "%s/.xbindkeysrc", home);
    snprintf(big_hour_file, sizeof(big_hour_file), "%s/.big_hour", home);

    // Create PID file
    int pid_fd = open("/tmp/clock_is_run_already.pid", O_WRONLY | O_CREAT | O_TRUNC, 0644);
    if (pid_fd >= 0) close(pid_fd);

    Display *dpy = XOpenDisplay(NULL);
    if (!dpy) {
        fprintf(stderr, "clock_osd: Cannot open X Display\n");
        return 1;
    }
    XSetErrorHandler(x11_silent_error_handler);
    Window root = DefaultRootWindow(dpy);

    // Create top-right OSD (4 lines: line 0,1 blank, line 2: BAT TIME, line 3: MODE)
    xosd *osd_top = xosd_create(4);
    if (!osd_top) {
        fprintf(stderr, "clock_osd: Cannot create top XOSD\n");
        XCloseDisplay(dpy);
        return 1;
    }
    xosd_set_pos(osd_top, XOSD_top);
    xosd_set_align(osd_top, XOSD_right);
    xosd_set_horizontal_offset(osd_top, 50);
    xosd_set_shadow_offset(osd_top, 1);
    xosd_set_timeout(osd_top, -1); // Persistent

    // Create bottom-right big ascii OSD (8 lines)
    xosd *osd_bottom = xosd_create(8);
    if (osd_bottom) {
        xosd_set_pos(osd_bottom, XOSD_bottom);
        xosd_set_align(osd_bottom, XOSD_right);
        xosd_set_shadow_offset(osd_bottom, 1);
        xosd_set_timeout(osd_bottom, -1);
    }

    setenv("TZ", "America/Lima", 1);
    tzset();

    int last_root_x = -1, last_root_y = -1;
    time_t last_move_time = time(NULL);
    const int IDLE_LIMIT = 100; // 100 seconds idle for big clock

    char last_color[32] = "";
    int top_visible = 0;
    int bottom_visible = 0;

    while (1) {
        // Flush X11 event queue to prevent connection choke
        while (XPending(dpy)) {
            XEvent ev;
            XNextEvent(dpy, &ev);
        }

        // Check if stopped
        if (access(stop_file, F_OK) == 0) {
            if (top_visible) {
                xosd_hide(osd_top);
                top_visible = 0;
            }
            if (bottom_visible && osd_bottom) {
                xosd_hide(osd_bottom);
                bottom_visible = 0;
            }
            usleep(200000); // 200ms
            continue;
        }

        // 1. Mouse query for idle detection
        Window root_ret, child_ret;
        int root_x, root_y, win_x, win_y;
        unsigned int mask;
        if (XQueryPointer(dpy, root, &root_ret, &child_ret, &root_x, &root_y, &win_x, &win_y, &mask)) {
            if (root_x != last_root_x || root_y != last_root_y) {
                last_root_x = root_x;
                last_root_y = root_y;
                last_move_time = time(NULL);
            }
        }

        time_t now = time(NULL);
        int idle_sec = (int)(now - last_move_time);
        int is_idle = (idle_sec >= IDLE_LIMIT);

        if (is_idle) {
            int fd = open(big_hour_file, O_WRONLY | O_CREAT | O_TRUNC, 0644);
            if (fd >= 0) close(fd);
        } else {
            unlink(big_hour_file);
        }

        // 2. Battery & Power
        int perc = read_sysfs_int("/sys/class/power_supply/BAT0/capacity");
        int online = read_sysfs_int("/sys/class/power_supply/ADP1/online");
        const char *bat_icon;
        if (online == 1) {
            bat_icon = "AC";
        } else {
            if (perc >= 85) bat_icon = "[===]";
            else if (perc >= 40) bat_icon = "[==-]";
            else if (perc >= 15) bat_icon = "[=--]";
            else bat_icon = "[---]";
        }

        // 3. Time formatting (12h format with a.m./p.m.)
        struct tm tm_info;
        localtime_r(&now, &tm_info);
        int hour12 = tm_info.tm_hour % 12;
        if (hour12 == 0) hour12 = 12;
        const char *ampm = (tm_info.tm_hour >= 12) ? "p.m." : "a.m.";

        char line_top1[128];
        snprintf(line_top1, sizeof(line_top1), "%s %d%% %02d:%02d:%02d %s",
                 bat_icon, perc, hour12, tm_info.tm_min, tm_info.tm_sec, ampm);

        // 4. Status modes and Color
        int xephyr_active = check_window_title_contains(dpy, root, "ctrl+shift releases");
        int not_mouse = file_contains(xbindkeys_file, "NOT MOUSE");

        const char *color;
        const char *mode_str;
        if (xephyr_active) {
            color = "red";
            mode_str = "Xephyr quit Ctrl+Shift";
        } else if (not_mouse) {
            color = "green";
            mode_str = "Keyboard quit Alt+2";
        } else {
            color = "orange";
            mode_str = "Mouse quit Alt+1";
        }

        // Apply color change if needed
        if (strcmp(last_color, color) != 0) {
            xosd_set_colour(osd_top, color);
            if (osd_bottom) xosd_set_colour(osd_bottom, color);
            strncpy(last_color, color, sizeof(last_color) - 1);
        }

        // Render Top OSD
        xosd_display(osd_top, 2, XOSD_string, line_top1);
        xosd_display(osd_top, 3, XOSD_string, mode_str);
        xosd_show(osd_top);
        top_visible = 1;

        // Render Bottom Big ASCII OSD if idle
        if (is_idle && osd_bottom) {
            char time_str[16];
            snprintf(time_str, sizeof(time_str), "%02d:%02d:%02d",
                     hour12, tm_info.tm_min, tm_info.tm_sec);

            char ascii_lines[8][256];
            for (int r = 0; r < 8; r++) ascii_lines[r][0] = '\0';

            for (int i = 0; time_str[i] != '\0'; i++) {
                char c = time_str[i];
                for (int r = 0; r < 8; r++) {
                    if (c >= '0' && c <= '9') {
                        strcat(ascii_lines[r], ascii_v[c - '0'][r]);
                    } else if (c == ':') {
                        strcat(ascii_lines[r], ascii_colon[r]);
                    }
                    strcat(ascii_lines[r], " ");
                }
            }

            for (int r = 0; r < 8; r++) {
                xosd_display(osd_bottom, r, XOSD_string, ascii_lines[r]);
            }
            xosd_show(osd_bottom);
            bottom_visible = 1;
        } else if (bottom_visible && osd_bottom) {
            xosd_hide(osd_bottom);
            bottom_visible = 0;
        }



        make_all_xosd_windows_sticky(dpy, root);
        usleep(100000); // 100ms tick
    }

    if (osd_top) xosd_destroy(osd_top);
    if (osd_bottom) xosd_destroy(osd_bottom);
    XCloseDisplay(dpy);
    return 0;
}
