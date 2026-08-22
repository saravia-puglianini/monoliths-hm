#define _GNU_SOURCE
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sys/wait.h>

/*
 * volume_ctrl.c - High-speed volume controller for ALSA / amixer
 * Eliminates Emacs batch macros and temporary files.
 * Usage:
 *   volume_ctrl up    (raises volume by 5%)
 *   volume_ctrl down  (lowers volume by 5%)
 *   volume_ctrl get   (prints current volume)
 */

static void run_amixer_set(const char *arg) {
    // Try Master first, then PCM
    pid_t pid = fork();
    if (pid == 0) {
        execlp("amixer", "amixer", "set", "Master", arg, NULL);
        _exit(1);
    }
    int status;
    waitpid(pid, &status, 0);

    // Also attempt PCM in case hardware uses PCM
    pid = fork();
    if (pid == 0) {
        execlp("amixer", "amixer", "set", "PCM", arg, NULL);
        _exit(1);
    }
    waitpid(pid, &status, 0);
}

static void print_current_volume(void) {
    FILE *fp = popen("amixer sget Master 2>/dev/null || amixer sget PCM 2>/dev/null", "r");
    if (!fp) {
        puts("100%");
        return;
    }
    char line[256];
    char vol[32] = "100%";
    while (fgets(line, sizeof(line), fp)) {
        if (strstr(line, "Playback") && strstr(line, "%")) {
            char *start = strchr(line, '[');
            if (start) {
                char *end = strchr(start, ']');
                if (end) {
                    size_t len = end - start - 1;
                    if (len < sizeof(vol)) {
                        strncpy(vol, start + 1, len);
                        vol[len] = '\0';
                        break;
                    }
                }
            }
        }
    }
    pclose(fp);
    puts(vol);
}

int main(int argc, char *argv[]) {
    if (argc < 2) {
        print_current_volume();
        return 0;
    }

    if (strcmp(argv[1], "up") == 0 || strcmp(argv[1], "raise") == 0 || strcmp(argv[1], "5+") == 0) {
        run_amixer_set("5+");
    } else if (strcmp(argv[1], "down") == 0 || strcmp(argv[1], "lower") == 0 || strcmp(argv[1], "5-") == 0) {
        run_amixer_set("5-");
    } else if (strcmp(argv[1], "get") == 0 || strcmp(argv[1], "actual") == 0) {
        print_current_volume();
    } else {
        run_amixer_set(argv[1]);
    }

    return 0;
}
