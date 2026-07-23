---------------------
---- KEYBINDINGS ----
---------------------
require("utilities")

hl.bind("F11", hl.dsp.window.fullscreen())
hl.bind("SUPER + RETURN", hl.dsp.exec_cmd("runapp kitty"))
hl.bind(
    "SUPER + SHIFT + RETURN",
    focus_or_launch(
        "tmux.main",
        'xdg-terminal-exec --app-id=tmux.main sh -c "tmux a || tmux"'
    )
)
hl.bind("SUPER + W", hl.dsp.window.close())
-- hl.bind("SUPER + R", focus_or_launch("ferdium", "ferdium"))
hl.bind("SUPER + SHIFT + B", focus_or_launch("zen", "zen-browser"))
hl.bind(
    "SUPER + ALT + B",
    focus_or_launch(
        "firefox-min",
        "firefox --name firefox-min -P firefox-min-profile"
    )
)

hl.bind("SUPER + SHIFT + E", hl.dsp.exec_cmd("runapp nautilus"))
hl.bind(
    "SUPER + E",
    hl.dsp.exec_cmd("runapp xdg-terminal-exec --app-id=tui.superfile spf")
)

hl.bind("SUPER + F", hl.dsp.window.float({ action = "toggle" }))

hl.bind("SUPER + left", hl.dsp.focus({ direction = "left" }))
hl.bind("SUPER + right", hl.dsp.focus({ direction = "right" }))
hl.bind("SUPER + ALT + up", hl.dsp.focus({ direction = "up" }))
hl.bind("SUPER + ALT + down", hl.dsp.focus({ direction = "down" }))

hl.bind("SUPER + up", hl.dsp.focus({ workspace = "-1" }))
hl.bind("SUPER + down", hl.dsp.focus({ workspace = "+1" }))
hl.bind("SUPER + ALT + left", hl.dsp.focus({ monitor = "-1" }))
hl.bind("SUPER + ALT + right", hl.dsp.focus({ monitor = "-1" }))
hl.bind("ALT + TAB", hl.dsp.window.cycle_next())

hl.bind("SUPER + SHIFT + D", function()
    local dim_inactive = hl.get_config("decoration.dim_inactive")
    hl.config({
        decoration = {
            dim_inactive = not dim_inactive,
        },
    })
end)

-- Switch workspaces with mainMod + [0-9]
-- Move active window to a workspace with mainMod + SHIFT + [0-9]
for i = 1, 10 do
    local key = i % 10 -- 10 maps to key 0
    hl.bind("SUPER + " .. key, hl.dsp.focus({ workspace = i }))
    hl.bind("SUPER + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- Scroll through existing workspaces with mainMod + scroll
hl.bind("SUPER + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind("SUPER + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

hl.bind("SUPER + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind("SUPER + mouse:273", hl.dsp.window.resize(), { mouse = true })

hl.bind("SUPER + CTRL + left", hl.dsp.layout("colresize -0.1"))
hl.bind("SUPER + CTRL + right", hl.dsp.layout("colresize +0.1"))

hl.bind("SUPER + SHIFT + left", hl.dsp.layout("swapcol l"))
hl.bind("SUPER + SHIFT + right", hl.dsp.layout("swapcol r"))

hl.bind("SUPER + SHIFT + comma", hl.dsp.layout("consume_or_expel prev"))
hl.bind("SUPER + SHIFT + period", hl.dsp.layout("consume_or_expel next"))

-- hl.bind("XF86Tools", focus_or_launch("spotify", "spotify-launcher"))
-- hl.bind("SUPER + M", focus_or_launch("spotify", "spotify-launcher"))

hl.bind("SUPER + G", function()
    hl.plugin.scrolloverview.overview("toggle")
    -- if hl.plugin.scrolloverview ~= nil then
    -- 	debug_print("Hello")
    -- end
end)
