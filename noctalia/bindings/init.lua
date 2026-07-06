IPC = "noctalia msg "

hl.bind("SUPER + SPACE", hl.dsp.exec_cmd(IPC .. "panel-toggle launcher"))
hl.bind("SUPER + A", hl.dsp.exec_cmd(IPC .. "panel-toggle launcher"))
hl.bind("SUPER + Escape", hl.dsp.exec_cmd(IPC .. "panel-toggle session"))
hl.bind("SUPER + ALT + DELETE", hl.dsp.exec_cmd(IPC .. "panel-toggle control-center system"))
hl.bind("SUPER + SHIFT + L", hl.dsp.exec_cmd(IPC .. "session lock"))

-- hl.bind("SUPER + semicolon", hl.dsp.exec_cmd(IPC .. "launcher command"))
hl.bind("SUPER + SHIFT + W", hl.dsp.exec_cmd(IPC .. "panel-toggle wallpaper"))
hl.bind("SUPER + SHIFT + S", hl.dsp.exec_cmd(IPC .. "settings-open"))
hl.bind("SUPER + SHIFT + C", hl.dsp.exec_cmd(IPC .. "panel-toggle control-center"))
hl.bind("SUPER + GRAVE", hl.dsp.exec_cmd(IPC .. "panel-toggle control-center"))

hl.bind("SUPER + L", hl.dsp.exec_cmd(IPC .. "panel-toggle clipboard"))
hl.bind("SUPER + N", hl.dsp.exec_cmd(IPC .. "panel-toggle control-center notifications"))
hl.bind("CTRL + SUPER + COMMA", hl.dsp.exec_cmd(IPC .. "notification-dnd-toggle"))
hl.bind("CTRL + SUPER + i", hl.dsp.exec_cmd(IPC .. "caffeine-toggle"))
hl.bind("SUPER + COMMA", hl.dsp.exec_cmd(IPC .. "notification-clear-active"))

hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd(IPC .. "volume-up"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd(IPC .. "volume-down"), { locked = true, repeating = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd(IPC .. "volume-mute"), { locked = true, repeating = true })
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd(IPC .. "mic-mute"), { locked = true, repeating = true })

hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd(IPC .. "brightness-up"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd(IPC .. "brightness-down"), { locked = true, repeating = true })

hl.bind("XF86AudioNext", hl.dsp.exec_cmd(IPC .. "media next"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd(IPC .. "media toggle"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd(IPC .. "media previous"), { locked = true })
