---------------------
---- KEYBINDINGS ----
---------------------

require("defaults")
require("utilities")
require("bindings.swayosd")

hl.bind("SUPER + RETURN", hl.dsp.exec_cmd(Terminal))
hl.bind("SUPER + W", hl.dsp.window.close())
hl.bind("SUPER + R", focus_or_launch("rambox", "rambox"))
hl.bind("SUPER + B", focus_or_launch("zen", "zen-browser"))
hl.bind("SUPER + COMMA", hl.dsp.exec_cmd("makoctl dismiss"))
hl.bind("SUPER + CTRL + i", hl.dsp.exec_cmd("omarchy-toggle-idle"))
hl.bind("SUPER + CTRL + COMMA", hl.dsp.exec_cmd("omarchy-toggle-notification-silencing"))

hl.bind("SUPER + E", hl.dsp.exec_cmd(FileManager))
hl.bind("SUPER + F", hl.dsp.window.float({ action = "toggle" }))
hl.bind("SUPER + A", hl.dsp.exec_cmd(Menu))

hl.bind("SUPER + left", hl.dsp.focus({ direction = "left" }))
hl.bind("SUPER + right", hl.dsp.focus({ direction = "right" }))

hl.bind("SUPER + up", hl.dsp.focus({ direction = "up" }))
hl.bind("SUPER + down", hl.dsp.focus({ direction = "down" }))

hl.bind("SUPER + ALT + up", hl.dsp.focus({ workspace = "-1" }))
hl.bind("SUPER + ALT + down", hl.dsp.focus({ workspace = "+1" }))

hl.bind("SUPER + ALT + left", hl.dsp.focus({ monitor = "-1" }))
hl.bind("SUPER + ALT + right", hl.dsp.focus({ monitor = "+1" }))

hl.bind("Print", hl.dsp.exec_cmd("omarchy-capture-screenshot"))

-- Switch workspaces with mainMod + [0-9]
-- Move active window to a workspace with mainMod + SHIFT + [0-9]
for i = 1, 10 do
	local key = i % 10 -- 10 maps to key 0
	hl.bind("SUPER + " .. key, hl.dsp.focus({ workspace = i }))
	hl.bind("SUPER + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- Example special workspace (scratchpad)
hl.bind("SUPER + S", hl.dsp.workspace.toggle_special("magic"))
hl.bind("SUPER + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

-- Scroll through existing workspaces with mainMod + scroll
hl.bind("SUPER + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind("SUPER + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind("SUPER + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind("SUPER + mouse:273", hl.dsp.window.resize(), { mouse = true })

hl.bind("SUPER + TAB", hl.dsp.exec_cmd("~/personal/omarchy-configuration/scripts/overview.py"))
hl.bind("SUPER + ESCAPE", hl.dsp.exec_cmd("omarchy-menu System"))
hl.bind("SUPER + SPACE", hl.dsp.exec_cmd("omarchy-menu"))

hl.bind("SUPER + CTRL + left", hl.dsp.layout("colresize -0.1"))
hl.bind("SUPER + CTRL + right", hl.dsp.layout("colresize +0.1"))

hl.bind("SUPER + SHIFT + left", hl.dsp.layout("swapcol l"))
hl.bind("SUPER + SHIFT + right", hl.dsp.layout("swapcol r"))

hl.bind("SUPER + SHIFT + comma", hl.dsp.layout("consume_or_expel prev"))
hl.bind("SUPER + SHIFT + period", hl.dsp.layout("consume_or_expel next"))
