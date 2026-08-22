#define _GNU_SOURCE
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sys/wait.h>

/*
 * play_pause_mpris.c - Fast MPRIS PlayPause dispatcher
 * Toggles Play/Pause on all active MPRIS Media Players.
 */

int main(void) {
    FILE *fp = popen("dbus-send --print-reply --dest=org.freedesktop.DBus /org/freedesktop/DBus org.freedesktop.DBus.ListNames 2>/dev/null", "r");
    if (!fp) return 1;

    char line[512];
    while (fgets(line, sizeof(line), fp)) {
        char *p = strstr(line, "org.mpris.MediaPlayer2.");
        if (p) {
            char *end = strchr(p, '"');
            if (end) {
                *end = '\0';
                pid_t pid = fork();
                if (pid == 0) {
                    execlp("dbus-send", "dbus-send", "--dest", p,
                           "/org/mpris/MediaPlayer2",
                           "org.mpris.MediaPlayer2.Player.PlayPause", NULL);
                    _exit(1);
                }
                int status;
                waitpid(pid, &status, 0);
            }
        }
    }
    pclose(fp);
    return 0;
}
