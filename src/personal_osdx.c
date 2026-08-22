#define _GNU_SOURCE
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <time.h>
#include <fcntl.h>
#include <xosd.h>
#include <X11/Xlib.h>
#include <X11/Xatom.h>

/*
 * personal_osdx.c - Ultra fast OSD battery and status display using libxosd
 */

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

    char big_hour_file[256];
    char xbindkeys_file[256];
    snprintf(big_hour_file, sizeof(big_hour_file), "%s/.big_hour", home);
    snprintf(xbindkeys_file, sizeof(xbindkeys_file), "%s/.xbindkeysrc", home);

    int perc = read_sysfs_int("/sys/class/power_supply/BAT0/capacity");
    int online = read_sysfs_int("/sys/class/power_supply/ADP1/online");

    const char *bat_icon;
    if (online == 1) {
        bat_icon = "⚡";
    } else {
        if (perc >= 85) bat_icon = "[███]";
        else if (perc >= 40) bat_icon = "[██░]";
        else if (perc >= 15) bat_icon = "[█░░]";
        else bat_icon = "[░░░]";
    }

    time_t now = time(NULL);
    struct tm tm_now;
    localtime_r(&now, &tm_now);

    int hr12 = tm_now.tm_hour % 12;
    if (hr12 == 0) hr12 = 12;
    const char *ampm = (tm_now.tm_hour >= 12) ? "p.m." : "a.m.";

    char line1[128] = "";
    if (access(big_hour_file, F_OK) != 0) {
        snprintf(line1, sizeof(line1), "%s %d%%  %02d:%02d %s", bat_icon, perc, hr12, tm_now.tm_min, ampm);
    }

    Display *dpy = XOpenDisplay(NULL);
    int xephyr_active = 0;
    if (dpy) {
        xephyr_active = check_window_title_contains(dpy, DefaultRootWindow(dpy), "ctrl+shift releases");
    }

    int not_mouse = file_contains(xbindkeys_file, "NOT MOUSE");
    const char *line2;
    const char *color;

    if (xephyr_active) {
        line2 = "Xephyr quit Ctrl+Shift";
        color = "red";
    } else if (not_mouse) {
        line2 = "Keyboard quit Alt+2";
        color = "green";
    } else {
        line2 = "Mouse quit Alt+1";
        color = "orange";
    }

    xosd *osd = xosd_create(4);
    if (osd) {
        xosd_set_pos(osd, XOSD_top);
        xosd_set_align(osd, XOSD_right);
        xosd_set_horizontal_offset(osd, 50);
        xosd_set_shadow_offset(osd, 1);
        xosd_set_timeout(osd, 1);
        xosd_set_colour(osd, color);

        xosd_display(osd, 2, XOSD_string, line1);
        xosd_display(osd, 3, XOSD_string, line2);
        xosd_wait_until_no_display(osd);
        xosd_destroy(osd);
    }

    if (dpy) XCloseDisplay(dpy);
    return 0;
}
