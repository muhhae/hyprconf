---@class vector2
---@field x? number
---@field y? number
---@class dropdown_config
---@field animation_in? string
---@field animation_out? string
---@field class? string
---@field cmd? string
---@field size? vector2
---@field pos? vector2
---@param opts? dropdown_config
function toggle_dropdown(opts)
	opts = opts or {}
	local class = opts.class or "float"
	local cmd = opts.cmd or ""
	local size = opts.size or { x = 0.6, y = 0.6 }
	local pos = opts.pos or { x = 0.5 - size.x / 2, y = 0.03287 }
	local animation_in = opts.animation_in or "slide top"
	local animation_out = opts.animation_out or "slide bottom"

	hl.animation({ leaf = "specialWorkspaceIn", enabled = true, speed = 3, bezier = "default", style = animation_in })
	hl.animation({ leaf = "specialWorkspaceOut", enabled = true, speed = 3, bezier = "default", style = animation_out })
	hl.animation({ leaf = "specialWorkspace", enabled = true, speed = 3, bezier = "default", style = animation_out })

	local windows = hl.get_windows()
	local dropdown = nil
	local special_name = class
	local workspace = "special:" .. special_name

	for _, w in ipairs(windows) do
		if w.initial_class == class then
			dropdown = w
			break
		end
	end

	if not dropdown then
		hl.window_rule({
			name = class,
			match = {
				initial_class = class,
			},
			float = true,
			move = { "monitor_w * " .. tostring(pos.x), "monitor_h * " .. tostring(pos.y) },
			size = { "monitor_w * " .. tostring(size.x), "monitor_h * " .. tostring(size.y) },
			workspace = workspace,
		})
		hl.exec_cmd(cmd)
		return
	end

	local window_workspace = dropdown.workspace.name or ""
	local is_on_special = window_workspace == workspace

	if is_on_special then
		hl.dispatch(hl.dsp.workspace.toggle_special(special_name))
	else
		hl.dispatch(hl.dsp.window.move({ workspace = workspace, window = dropdown }))
		hl.dispatch(hl.dsp.workspace.toggle_special(special_name))
	end
end

---@param opts {class: string, cmd: string}
function toggle_dropdown_term(opts)
	local prefix = "term"
	local class = prefix .. "." .. opts.class
	local cmd = opts.cmd

	toggle_dropdown({
		class = class,
		cmd = "xdg-terminal-exec --app-id=" .. class .. " -e sh -c '" .. cmd .. "'",
	})
end

-- Toggle dropdown terminal
hl.bind("SUPER + T", function()
	toggle_dropdown_term({ class = "zsh", cmd = "zsh" })
end)

hl.bind("SUPER + K", function()
	toggle_dropdown_term({ class = "kilo", cmd = "mkdir -p ~/notes && cd ~/notes && kilo -c" })
end)

hl.bind("SUPER + Z", function()
	toggle_dropdown({ class = "Zotero", cmd = "zotero" })
end)

hl.bind("SUPER + H", function()
	toggle_dropdown_term({ class = "ask.hypr", cmd = "cd ~/hyprland-wiki && kilo -c" })
end)
