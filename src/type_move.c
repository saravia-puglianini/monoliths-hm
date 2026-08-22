/*
 * type_move.c - Ultra high speed assembly/C cursor and action controller for type-to-move-cursor
 * Eliminates xdotool and xset fork/exec overhead. Direct X11 & XTest extension calls.
 *
 * Supported Actions:
 *   move <dx_fast> <dy_fast> <dx_normal> <dy_normal>
 *   wrapper <z|y>
 *   click <button>
 *   click_repeat <button> <count>
 *   mousedown <button>
 *   mouseup <button>
 *   release_all
 *   drag_start
 *   toggle_middle
 *   ctrl_wheel <button>
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <X11/Xlib.h>
#include <X11/keysym.h>
#include <X11/extensions/XTest.h>
#include <X11/XKBlib.h>

static int is_capslock_on(Display *dpy) {
    XKeyboardState state;
    XGetKeyboardControl(dpy, &state);
    return (state.led_mask & 1) ? 1 : 0;
}

static void move_relative(Display *dpy, int dx, int dy) {
    XTestFakeRelativeMotionEvent(dpy, dx, dy, CurrentTime);
    XFlush(dpy);
}

static void mouse_button(Display *dpy, unsigned int button, int is_press) {
    XTestFakeButtonEvent(dpy, button, is_press ? True : False, CurrentTime);
    XFlush(dpy);
}

static void mouse_click(Display *dpy, unsigned int button) {
    mouse_button(dpy, button, 1);
    usleep(1000); // 1ms
    mouse_button(dpy, button, 0);
}

int main(int argc, char *argv[]) {
    if (argc < 2) {
        fprintf(stderr, "Usage: %s <action> [args...]\n", argv[0]);
        return 1;
    }

    Display *dpy = XOpenDisplay(NULL);
    if (!dpy) {
        fprintf(stderr, "type_move: Cannot open X Display\n");
        return 1;
    }

    const char *action = argv[1];

    if (strcmp(action, "move") == 0) {
        int dx_fast = (argc > 2) ? atoi(argv[2]) : 0;
        int dy_fast = (argc > 3) ? atoi(argv[3]) : 0;
        int dx_norm = (argc > 4) ? atoi(argv[4]) : 0;
        int dy_norm = (argc > 5) ? atoi(argv[5]) : 0;

        int caps = is_capslock_on(dpy);
        int dx = caps ? dx_fast : dx_norm;
        int dy = caps ? dy_fast : dy_norm;
        move_relative(dpy, dx, dy);
    }
    else if (strcmp(action, "wrapper") == 0) {
        int caps = is_capslock_on(dpy);
        int dx = caps ? -32 : -8;
        int dy = caps ? 32 : 8;
        move_relative(dpy, dx, dy);
    }
    else if (strcmp(action, "click") == 0) {
        int btn = (argc > 2) ? atoi(argv[2]) : 1;
        mouse_click(dpy, (unsigned int)btn);
    }
    else if (strcmp(action, "click_repeat") == 0) {
        int btn = (argc > 2) ? atoi(argv[2]) : 4;
        int count = (argc > 3) ? atoi(argv[3]) : 1;
        for (int i = 0; i < count; i++) {
            mouse_click(dpy, (unsigned int)btn);
            if (i < count - 1) usleep(10000);
        }
    }
    else if (strcmp(action, "mousedown") == 0) {
        int btn = (argc > 2) ? atoi(argv[2]) : 1;
        mouse_button(dpy, (unsigned int)btn, 1);
    }
    else if (strcmp(action, "mouseup") == 0) {
        int btn = (argc > 2) ? atoi(argv[2]) : 1;
        mouse_button(dpy, (unsigned int)btn, 0);
    }
    else if (strcmp(action, "release_all") == 0) {
        mouse_button(dpy, 1, 0);
        mouse_button(dpy, 2, 0);
        mouse_button(dpy, 3, 0);
    }
    else if (strcmp(action, "drag_start") == 0) {
        mouse_click(dpy, 1);
        usleep(50000);
        mouse_button(dpy, 1, 1);
        usleep(50000);
        move_relative(dpy, 1, 0);
    }
    else if (strcmp(action, "toggle_middle") == 0) {
        int caps = is_capslock_on(dpy);
        if (caps) {
            mouse_button(dpy, 2, 1);
        } else {
            mouse_button(dpy, 2, 0);
        }
    }
    else if (strcmp(action, "ctrl_wheel") == 0) {
        int btn = (argc > 2) ? atoi(argv[2]) : 4;
        KeyCode ctrl = XKeysymToKeycode(dpy, XK_Control_L);
        if (!ctrl) ctrl = XKeysymToKeycode(dpy, XK_Control_R);
        if (ctrl) {
            XTestFakeKeyEvent(dpy, ctrl, True, CurrentTime);
            XFlush(dpy);
            usleep(10000);
            mouse_click(dpy, (unsigned int)btn);
            usleep(10000);
            XTestFakeKeyEvent(dpy, ctrl, False, CurrentTime);
            XFlush(dpy);
        }
    }
    else {
        fprintf(stderr, "Unknown action: %s\n", action);
        XCloseDisplay(dpy);
        return 1;
    }

    XCloseDisplay(dpy);
    return 0;
}
