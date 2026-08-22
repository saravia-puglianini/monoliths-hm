CC = gcc
CFLAGS = -O3 -fomit-frame-pointer -Wall
XOSD_LIBS = -lxosd -lX11 -lpthread
XI_LIBS = -lX11 -lXi

TARGETS = bin/clock_osd bin/hour_counter_osd bin/trackball_calibrator bin/simple_timer bin/volume_ctrl bin/jbl_mic_loop bin/jbl_mic_set bin/change_brightness bin/play_pause_mpris bin/second_counter bin/personal_osdx
ASM_TARGETS = src/clock_osd.s src/hour_counter_osd.s src/trackball_calibrator.s src/simple_timer.s src/volume_ctrl.s src/change_brightness.s src/play_pause_mpris.s src/personal_osdx.s

all: dirs asm $(TARGETS)

dirs:
	@mkdir -p bin src

asm: $(ASM_TARGETS)

src/%.s: src/%.c
	$(CC) $(CFLAGS) -masm=intel -S $< -o $@

bin/clock_osd: src/clock_osd.s
	$(CC) $(CFLAGS) $< $(XOSD_LIBS) -o $@

bin/hour_counter_osd: src/hour_counter_osd.s
	$(CC) $(CFLAGS) $< $(XOSD_LIBS) -o $@

bin/trackball_calibrator: src/trackball_calibrator.s
	$(CC) $(CFLAGS) $< $(XI_LIBS) -o $@

bin/simple_timer: src/simple_timer.s
	$(CC) $(CFLAGS) $< -o $@

bin/volume_ctrl: src/volume_ctrl.s
	$(CC) $(CFLAGS) $< -o $@

bin/jbl_mic_loop: src/jbl_mic_loop.s
	$(CC) -nostdlib -static $< -o $@

bin/jbl_mic_set: src/jbl_mic_set.s
	$(CC) -nostdlib -static $< -o $@

bin/change_brightness: src/change_brightness.s
	$(CC) $(CFLAGS) $< -o $@

bin/play_pause_mpris: src/play_pause_mpris.s
	$(CC) $(CFLAGS) $< -o $@

bin/second_counter: src/second_counter.s
	$(CC) -nostdlib -static $< -o $@

bin/personal_osdx: src/personal_osdx.s
	$(CC) $(CFLAGS) $< $(XOSD_LIBS) -o $@

clean:
	rm -f $(TARGETS) $(ASM_TARGETS)

.PHONY: all dirs asm clean
