/*
 * trackball_calibrator.c - Native calibrator for Perixx Trackball
 * Sets libinput Accel Speed and Profile without spawning shell processes.
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <X11/Xlib.h>
#include <X11/extensions/XInput.h>
#include <X11/extensions/XInput2.h>
#include <X11/Xatom.h>

static void calibrate(Display *dpy) {
    int num_devices = 0;
    XIDeviceInfo *info = XIQueryDevice(dpy, XIAllDevices, &num_devices);
    if (!info) return;

    Atom float_atom = XInternAtom(dpy, "FLOAT", True);

    for (int i = 0; i < num_devices; i++) {
        if (info[i].name && strstr(info[i].name, "SONiX Perixx Trackball Keyboard Mouse")) {
            int dev_id = info[i].deviceid;
            
            // Set 'libinput Accel Speed' to -1.0
            Atom prop_speed = XInternAtom(dpy, "libinput Accel Speed", True);
            if (prop_speed != None && float_atom != None) {
                float val = -1.0f;
                XIChangeProperty(dpy, dev_id, prop_speed, float_atom, 32,
                                 PropModeReplace, (unsigned char *)&val, 1);
            }

            // Set 'libinput Accel Profile Enabled' to 1 0
            Atom prop_profile = XInternAtom(dpy, "libinput Accel Profile Enabled", True);
            if (prop_profile != None) {
                unsigned char vals[2] = {1, 0};
                XIChangeProperty(dpy, dev_id, prop_profile, XA_INTEGER, 8,
                                 PropModeReplace, vals, 2);
            }

            XFlush(dpy);
        }
    }
    XIFreeDeviceInfo(info);
}

int main(void) {
    Display *dpy = XOpenDisplay(NULL);
    if (!dpy) return 1;

    while (1) {
        calibrate(dpy);
        sleep(1);
    }

    XCloseDisplay(dpy);
    return 0;
}
