/*
 * simple_timer.c - Ultra light Assembly / C Countdown Timer
 * Replaces simple_second_counter and timer.sh
 */

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <signal.h>

static volatile int keep_running = 1;

static void handle_sig(int sig) {
    (void)sig;
    keep_running = 0;
}

int main(int argc, char *argv[]) {
    int total_seconds = 60;
    if (argc > 1) {
        total_seconds = atoi(argv[1]);
        if (total_seconds <= 0) total_seconds = 60;
    }

    signal(SIGINT, handle_sig);
    signal(SIGTERM, handle_sig);

    for (int s = total_seconds; s >= 0 && keep_running; s--) {
        int m = s / 60;
        int sec = s % 60;
        printf("\r\033[K[Temporizador] %02d:%02d (%d s restantes)", m, sec, s);
        fflush(stdout);
        if (s > 0) sleep(1);
    }

    printf("\n¡Tiempo finalizado!\n");
    return 0;
}
