--------------------------------
---- WINDOWS AND WORKSPACES ----
--------------------------------

-- See https://wiki.hypr.land/Configuring/Basics/Window-Rules/
-- and https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/
-- Example window rules that are useful
--

hl.window_rule({
	enabled = false,
	name = "1_starting_width",
	match = { initial_class = "factorio|zen|ferdium|steam|antigravity" },
	scrolling_width = 1,
})

-- org.cachyos.KernelManager
hl.window_rule({
    name = "floating-app-no-resize",
    match = {
        initial_class = "org.cachyos.KernelManager",
    },
    float = true,
    center = true,
})

hl.window_rule({
    name = "screen-picker",
    match = {
        initial_class = "hyprland-share-picker|xdg-desktop-portal-gtk",
    },
    float = true,
    center = true,
    size = { "(monitor_w*0.6)", "(monitor_h*0.6)" },
})

hl.window_rule({
    name = "blur-terminal",
    match = {
        initial_class = "ghostty",
    },
})

local floating_apps = {
    { initial_title = "hyprmon|lazygit|Steam Settings" },
    {
        initial_class = "com.gabm.satty|ferdium|spotify|TUI.float|dev.noctalia.Noctalia.Settings",
    },
}

for i, target in ipairs(floating_apps) do
    hl.window_rule({
        name = "floating-app-" .. i,
        match = target,
        float = true,
        center = true,
        size = { "(monitor_w*0.8)", "(monitor_h*0.8)" },
    })
end

hl.window_rule({
    name = "floating-waypaper",
    match = {
        initial_class = "waypaper",
    },
    float = true,
    center = true,
    size = { "(monitor_w * 0.5)", "(monitor_h*0.5)" },
})

local suppressMaximizeRule = hl.window_rule({
    -- Ignore maximize requests from all apps. You'll probably like this.
    name = "suppress-maximize-events",
    match = { class = ".*" },

    suppress_event = "maximize",
})
-- suppressMaximizeRule:set_enabled(false)

hl.window_rule({
    -- Fix some dragging issues with XWayland
    name = "fix-xwayland-drags",
    match = {
        class = "^$",
        title = "^$",
        xwayland = true,
        float = true,
        fullscreen = false,
        pin = false,
    },

    no_focus = true,
})

-- Layer rules also return a handle.
-- local overlayLayerRule = hl.layer_rule({
--     name  = "no-anim-overlay",
--     match = { namespace = "^my-overlay$" },
--     no_anim = true,
-- })
-- overlayLayerRule:set_enabled(false)

-- Hyprland-run windowrule
hl.window_rule({
    name = "move-hyprland-run",
    match = { class = "hyprland-run" },

    move = "20 monitor_h-120",
    float = true,
})

hl.window_rule({
    name = "Zoom",
    match = {
        initial_class = "Zoom",
        initial_title = "zoom|as_toolbar|zoom_linux_float_video_window|annotate_toolbar",
    },
    float = true,
    -- pin = true,
})

hl.window_rule({
    name = "PIP",
    match = {
        initial_title = "Picture-in-Picture",
    },
    float = true,
    pin = true,
    -- size = { "(monitor_w * 0.5)", "(monitor_h*0.5)" },
})

hl.window_rule({
    name = "spotify-pip",
    match = {
        initial_class = "chromium-browser",
    },
    float = true,
    pin = true,
    no_dim = true,
})
