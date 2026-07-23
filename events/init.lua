hl.on("monitor.added", function(m)
    -- hl.exec_cmd("xdg-terminal-exec --title=hyprmon hyprmon")
end)

hl.on("window.title", function(w)
	-- if w.title == "hyprmon" and w.initial_title == "Ghostty" then
	-- 	hl.dispatch(hl.dsp.window.float({ window = w, action = "set" }))
	-- 	hl.dispatch(hl.dsp.window.center({ window = w, action = "set" }))
	--    return
	-- end
end)
