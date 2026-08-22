/*
 * hour_counter_osd.c - High performance Assembly / C implementation of Contar_Horas
 * Handles .acounter time tracking, ASCII art font generation and XOSD display.
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

static const char *ascii_v[10][8] = {
    { "  /$$$$$$ ", " /$$$_  $$", "| $$$$\\ $$", "| $$ $$ $$", "| $$\\ $$$$", "| $$ \\ $$$", "|  $$$$$$/", " \\______/ " },
    { "   /$$    ", " /$$$$    ", "|_  $$    ", "  | $$    ", "  | $$    ", "  | $$    ", " /$$$$$$  ", "|______/  " },
    { "  /$$$$$$ ", " /$$__  $$", "|__/  \\ $$", "  /$$$$$$/", " /$$____/ ", "| $$      ", "| $$$$$$$$", "|________/" },
    { "  /$$$$$$ ", " /$$__  $$", "|__/  \\ $$", "   /$$$$$/", "  |___  $$", " /$$  \\ $$", "|  $$$$$$/", " \\______/ " },
    { " /$$   /$$", "| $$  | $$", "| $$  | $$", "| $$$$$$$$", "|_____  $$", "      | $$", "      | $$", "      |__/" },
    { " /$$$$$$$ ", "| $$____/ ", "| $$      ", "| $$$$$$$ ", "|_____  $$", " /$$  \\ $$", "|  $$$$$$/", " \\______/ " },
    { "  /$$$$$$ ", " /$$__  $$", "| $$  \\__/", "| $$$$$$$ ", "| $$__  $$", "| $$  \\ $$", "|  $$$$$$/", " \\______/ " },
    { " /$$$$$$$$", "|_____ $$/", "     /$$/ ", "    /$$/  ", "   /$$/   ", "  /$$/    ", " /$$/     ", "|__/      " },
    { "  /$$$$$$ ", " /$$__  $$", "| $$  \\ $$", "|  $$$$$$/", " >$$__  $$", "| $$  \\ $$", "|  $$$$$$/", " \\______/ " },
    { "  /$$$$$$ ", " /$$__  $$", "| $$  \\ $$", "|  $$$$$$$", " \\____  $$", " /$$  \\ $$", "|  $$$$$$/", " \\______/ " }
};

static const char *ascii_colon[8] = {
    "    ", " /$$", "|__/", "    ", " /$$", "|__/", "    ", "    "
};

static const char *ascii_H[8] = {
    " /$$   /$$", "| $$  | $$", "| $$  | $$", "| $$$$$$$$", "| $$__  $$", "| $$  | $$", "| $$  | $$", "|__/  |__/"
};

static const char *ascii_O[8] = {
    "  /$$$$$$ ", " /$$__  $$", "| $$  \\ $$", "| $$  | $$", "| $$  | $$", "| $$  | $$", "|  $$$$$$/", " \\______/ "
};

static const char *ascii_R[8] = {
    " /$$$$$$$ ", "| $$__  $$", "| $$  \\ $$", "| $$$$$$$/", "| $$__  $$", "| $$  \\ $$", "| $$  | $$", "|__/  |__/"
};

static const char *ascii_A[8] = {
    "  /$$$$$$ ", " /$$__  $$", "| $$  \\ $$", "| $$$$$$$$", "| $$__  $$", "| $$  | $$", "| $$  | $$", "|__/  |__/"
};

static const char *ascii_S[8] = {
    "  /$$$$$$ ", " /$$__  $$", "| $$  \\__/", "|  $$$$$$ ", " \\____  $$", " /$$  \\ $$", "|  $$$$$$/", " \\______/ "
};

static const char** get_char_block(char c) {
    if (c >= '0' && c <= '9') return ascii_v[c - '0'];
    if (c == ':') return ascii_colon;
    if (c == 'H' || c == 'h') return ascii_H;
    if (c == 'O' || c == 'o') return ascii_O;
    if (c == 'R' || c == 'r') return ascii_R;
    if (c == 'A' || c == 'a') return ascii_A;
    if (c == 'S' || c == 's') return ascii_S;
    return ascii_colon;
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

static int update_and_get_total_dots(const char *acounter_path, time_t cur_epoch) {
    struct tm cur_tm;
    localtime_r(&cur_epoch, &cur_tm);
    char cur_date_hr[32];
    snprintf(cur_date_hr, sizeof(cur_date_hr), "%04d%02d%02d%02d%02d",
             cur_tm.tm_year + 1900, cur_tm.tm_mon + 1, cur_tm.tm_mday,
             cur_tm.tm_hour, cur_tm.tm_min);

    FILE *f = fopen(acounter_path, "r+");
    if (!f) {
        f = fopen(acounter_path, "w+");
        if (!f) return 0;
        fputs(cur_date_hr, f);
        fclose(f);
        return 0;
    }

    char last_line[1024] = "";
    char line[1024];
    int total_dots = 0;

    while (fgets(line, sizeof(line), f)) {
        for (int i = 0; line[i]; i++) {
            if (line[i] == '.') total_dots++;
        }
        // Trim newline
        size_t len = strlen(line);
        while (len > 0 && (line[len-1] == '\n' || line[len-1] == '\r')) {
            line[--len] = '\0';
        }
        if (len > 0) {
            strncpy(last_line, line, sizeof(last_line) - 1);
        }
    }

    size_t last_len = strlen(last_line);
    if (last_len < 12) {
        fseek(f, 0, SEEK_END);
        fprintf(f, "\n%s", cur_date_hr);
        fclose(f);
        return total_dots;
    }

    char base_str[13];
    strncpy(base_str, last_line, 12);
    base_str[12] = '\0';

    int num_dots = (int)last_len - 12;

    int y, m, d, hr, mn;
    if (sscanf(base_str, "%4d%2d%2d%2d%2d", &y, &m, &d, &hr, &mn) == 5) {
        struct tm base_tm = {0};
        base_tm.tm_year = y - 1900;
        base_tm.tm_mon = m - 1;
        base_tm.tm_mday = d;
        base_tm.tm_hour = hr;
        base_tm.tm_min = mn;
        base_tm.tm_isdst = -1;
        time_t base_epoch = mktime(&base_tm);
        if (base_epoch != (time_t)-1) {
            time_t expected_epoch = base_epoch + num_dots * 3600;
            long diff_hours = (long)(cur_epoch - expected_epoch) / 3600;

            if (diff_hours == 1) {
                fseek(f, 0, SEEK_END);
                fputc('.', f);
                total_dots++;
            } else if (diff_hours > 1 || cur_epoch < expected_epoch) {
                fseek(f, 0, SEEK_END);
                fprintf(f, "\n%s", cur_date_hr);
            }
        }
    }

    fclose(f);
    return total_dots;
}

int main(void) {
    const char *home = getenv("HOME");
    if (!home) home = "/home/user";

    char stop_file[256];
    char xbindkeys_file[256];
    char big_counter_file[256];
    char acounter_file[256];
    snprintf(stop_file, sizeof(stop_file), "%s/.stop_personal_osdx", home);
    snprintf(xbindkeys_file, sizeof(xbindkeys_file), "%s/.xbindkeysrc", home);
    snprintf(big_counter_file, sizeof(big_counter_file), "%s/.big_hour_counter", home);
    snprintf(acounter_file, sizeof(acounter_file), "%s/.acounter", home);

    int pid_fd = open("/tmp/Contar_Horas_counter_is_run_already.pid", O_WRONLY | O_CREAT | O_TRUNC, 0644);
    if (pid_fd >= 0) close(pid_fd);

    Display *dpy = XOpenDisplay(NULL);
    if (!dpy) {
        fprintf(stderr, "hour_counter_osd: Cannot open X Display\n");
        return 1;
    }
    Window root = DefaultRootWindow(dpy);

    xosd *osd = xosd_create(8);
    if (!osd) {
        fprintf(stderr, "hour_counter_osd: Cannot create XOSD\n");
        XCloseDisplay(dpy);
        return 1;
    }
    xosd_set_pos(osd, XOSD_bottom);
    xosd_set_align(osd, XOSD_left);
    xosd_set_shadow_offset(osd, 1);
    xosd_set_timeout(osd, -1);

    int last_root_x = -1, last_root_y = -1;
    time_t last_move_time = time(NULL);
    const int IDLE_LIMIT = 5; // 5 seconds limit as per hour_big_count_ascii.sh

    char last_color[32] = "";
    int is_visible = 0;

    while (1) {
        if (access(stop_file, F_OK) == 0) {
            if (is_visible) {
                xosd_hide(osd);
                is_visible = 0;
            }
            usleep(200000);
            continue;
        }

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
            int fd = open(big_counter_file, O_WRONLY | O_CREAT | O_TRUNC, 0644);
            if (fd >= 0) close(fd);

            int total_dots = update_and_get_total_dots(acounter_file, now);
            char disp_string[64];
            if (total_dots == 1) {
                snprintf(disp_string, sizeof(disp_string), "%dHORA", total_dots);
            } else {
                snprintf(disp_string, sizeof(disp_string), "%dHORAS", total_dots);
            }

            char ascii_lines[8][512];
            for (int r = 0; r < 8; r++) ascii_lines[r][0] = '\0';

            for (int i = 0; disp_string[i] != '\0'; i++) {
                const char **block = get_char_block(disp_string[i]);
                for (int r = 0; r < 8; r++) {
                    strcat(ascii_lines[r], block[r]);
                    strcat(ascii_lines[r], " ");
                }
            }

            int xephyr_active = check_window_title_contains(dpy, root, "ctrl+shift releases");
            int not_mouse = file_contains(xbindkeys_file, "NOT MOUSE");
            const char *color;
            if (xephyr_active) color = "red";
            else if (not_mouse) color = "green";
            else color = "orange";

            if (strcmp(last_color, color) != 0) {
                xosd_set_colour(osd, color);
                strncpy(last_color, color, sizeof(last_color) - 1);
            }

            for (int r = 0; r < 8; r++) {
                xosd_display(osd, r, XOSD_string, ascii_lines[r]);
            }

            if (!is_visible) {
                xosd_show(osd);
                is_visible = 1;
            }
        } else {
            unlink(big_counter_file);
            if (is_visible) {
                xosd_hide(osd);
                is_visible = 0;
            }
        }

        usleep(100000); // 100ms
    }

    xosd_destroy(osd);
    XCloseDisplay(dpy);
    return 0;
}
