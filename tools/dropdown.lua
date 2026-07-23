---@class vector2
---@field x? number
---@field y? number

---@class drawer_opts
---@field class string
---@field follow_class? string
---@field cmd string
---@field float? boolean
---@field preset? "top" | "bottom" | "left" | "right"
---@field size? vector2
---@field pos? vector2
---@field animation? {a?: string, b?: string, speed?: number}

---@type drawer_opts
local drawer_opts_default = {
    class = "",
    cmd = "",
    float = true,
    preset = "top",
    animation = { speed = 3 },
}

---@type {top: drawer_opts, bottom: drawer_opts, right: drawer_opts, left: drawer_opts}
local drawer_preset = {
    top = {
        class = "",
        cmd = "",
        size = { x = 0.6, y = 0.6 },
        pos = { x = 0.5 },
        animation = { a = "slide top", b = "slide bottom" },
    },
    bottom = {
        class = "",
        cmd = "",
        size = { x = 0.6, y = 0.6 },
        pos = { x = 0.5 },
        animation = { a = "slide bottom", b = "slide top" },
    },
    left = {
        class = "",
        cmd = "",
        size = { x = 0.35, y = 1 },
        pos = { y = 0.5 },
        animation = { a = "slide left", b = "slide right" },
    },
    right = {
        class = "",
        cmd = "",
        size = { x = 0.35, y = 1 },
        pos = { y = 0.5 },
        animation = { a = "slide right", b = "slide left" },
    },
}

---@param opts drawer_opts
local function apply_animations(opts)
    hl.animation({
        leaf = "specialWorkspaceIn",
        enabled = true,
        speed = opts.animation.speed,
        bezier = "default",
        style = opts.animation.a,
    })
    hl.animation({
        leaf = "specialWorkspaceOut",
        enabled = true,
        speed = opts.animation.speed,
        bezier = "default",
        style = opts.animation.b,
    })
end

---@param opts drawer_opts
---@return drawer_opts
local function apply_presets(opts)
    ---@type drawer_opts
    opts = deep_merge(drawer_opts_default, opts)
    ---@type drawer_opts
    opts = deep_merge(drawer_preset[opts.preset], opts)
    if not opts.pos.y then
        if opts.preset == "top" then
            opts.pos.y = opts.size.y / 2
        elseif opts.preset == "bottom" then
            opts.pos.y = 1 - opts.size.y + opts.size.y / 2
        end
    end
    if not opts.pos.x then
        if opts.preset == "right" then
            opts.pos.x = 1 - opts.size.x + opts.size.x / 2
        elseif opts.preset == "left" then
            opts.pos.x = opts.size.x / 2
        end
    end
    return opts
end

---@param opts drawer_opts
local function apply_style(opts)
    local rule = {
        name = opts.class,
        match = {
            initial_class = opts.class,
        },
        float = opts.float,
        move = {
            "monitor_w * " .. tostring(opts.pos.x - opts.size.x / 2),
            "35 + (monitor_h - 35) * "
                .. tostring(opts.pos.y - opts.size.y / 2),
        },
        size = {
            "monitor_w * " .. tostring(opts.size.x),
            "(monitor_h - 35) * " .. tostring(opts.size.y),
        },
        workspace = "special:" .. opts.class,
    }
    hl.window_rule(rule)
end

---@param opts drawer_opts
local function toggle_drawer(opts)
    ---@type HL.Window?
    local dropdown = nil
    for _, w in ipairs(hl.get_windows()) do
        if w.initial_class == opts.class then
            dropdown = w
            break
        end
    end
    apply_animations(opts)
    if not dropdown then
        hl.exec_cmd("runapp " .. opts.cmd)
    else
        if dropdown.workspace.name ~= "special:" .. opts.class then
            hl.dispatch(hl.dsp.window.move({
                workspace = "special:" .. opts.class,
                window = dropdown,
            }))
        else
            hl.dispatch(hl.dsp.workspace.toggle_special(opts.class))
        end
    end
end

---@param opts drawer_opts
local function get_drawer_term_opts(opts)
    opts = copy(opts)
    opts.class = "term." .. opts.class
    opts.cmd = "xdg-terminal-exec --app-id="
        .. opts.class
        .. ' -e sh -c "'
        .. opts.cmd
        .. '"'
    return opts
end

---@type {[string]: drawer_opts}
local term = {
    terminal = {
        class = "terminal",
        cmd = "zsh",
        -- cmd = "tmux a || tmux",
    },
    kilo = {
        class = "kilo",
        cmd = "kilo",
        -- cmd = "kilosearch.sh",
        preset = "right",
    },
    musicplayertui = {
        class = "music-player-tui",
        cmd = "spotify_player",
    },
    lyse = {
        class = "lyse",
        cmd = "~/go/bin/lyse",
        size = { x = 0.2, y = 0.6 },
    },
    hypr_ai = {
        class = "ask.hypr",
        cmd = "cd ~/hyprland-wiki && kilo -c",
        preset = "right",
    },
    notes = { class = "notes", cmd = "note" },
}

for k, v in pairs(term) do
    term[k] = apply_presets(get_drawer_term_opts(v))
end

local gui = {
    zotero = {
        class = "zotero-dropdown",
        cmd = "zotero --name zotero-dropdown",
        float = false,
        preset = "left",
    },
    spotify = {
        class = "spotify",
        cmd = "spotify-launcher",
    },
    fire_dropdown = {
        class = "firefox-dropdown",
        cmd = "firefox --name firefox-dropdown -P firefox-dropdown-profile",
        size = { x = 0.8, y = 0.8 },
    },
    fireport = {
        class = "fireport",
        cmd = "firefox -p fireport-profile --name fireport",
        size = { x = 0.8, y = 0.8 },
    },
}

for k, v in pairs(gui) do
    gui[k] = apply_presets(v)
end

local mapping = {
    -- ["SUPER + Z"] = gui.zotero,
    ["SUPER + B"] = gui.fire_dropdown,
    ["SUPER + R"] = gui.fireport,
    ["SUPER + T"] = term.terminal,
    ["SUPER + K"] = term.kilo,
    ["SUPER + H"] = term.hypr_ai,
    -- ["SUPER + ALT + M"] = term.musicplayertui,
    ["SUPER + ALT + M"] = gui.spotify,
    ["SUPER + M"] = term.lyse,
    ["SUPER + SHIFT + N"] = term.notes,
}
local autostarts = {
    gui.spotify,
    gui.fire_dropdown,
    term.kilo,
    gui.fireport,
}

for _, v in ipairs(mapping) do
    apply_style(v)
end

hl.on("hyprland.start", function()
    for _, v in ipairs(autostarts) do
        toggle_drawer(v)
    end
end)

local function close_special_workspace()
    local workspace = hl.get_active_special_workspace()
    if not workspace then
        return
    end
    local name = string.gsub(workspace.name, "^special:", "")
    hl.dispatch(hl.dsp.workspace.toggle_special(name))
end

hl.bind("SUPER + Q", close_special_workspace)

for k, v in pairs(mapping) do
    hl.bind(k, function()
        toggle_drawer(v)
    end)
end
