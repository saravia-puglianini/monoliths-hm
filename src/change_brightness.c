#define _GNU_SOURCE
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sys/wait.h>

/*
 * change_brightness.c - High speed brightness changer
 * Usage:
 *   change_brightness up
 *   change_brightness down
 */

static double get_current_brightness(void) {
    FILE *fp = popen("xrandr --verbose 2>/dev/null", "r");
    if (!fp) return 1.0;

    char line[512];
    double b = 1.0;
    while (fgets(line, sizeof(line), fp)) {
        if (strcasestr(line, "brightness")) {
            char *colon = strchr(line, ':');
            if (colon) {
                b = atof(colon + 1);
                break;
            }
        }
    }
    pclose(fp);
    return b;
}

int main(int argc, char *argv[]) {
    if (argc < 2) return 1;

    double curr = get_current_brightness();
    double next = curr;

    if (strcmp(argv[1], "up") == 0) {
        next = curr + 0.05;
        if (next > 1.0) next = 1.0;
    } else {
        next = curr - 0.05;
        if (next < 0.1) next = 0.1;
    }

    char next_str[32];
    snprintf(next_str, sizeof(next_str), "%.2f", next);

    pid_t pid = fork();
    if (pid == 0) {
        execlp("xrandr", "xrandr", "--output", "eDP-1", "--brightness", next_str, NULL);
        _exit(1);
    }
    int status;
    waitpid(pid, &status, 0);

    return 0;
}
