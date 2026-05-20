--- Focus or Launch an App
--- @param initial_class string
--- @param executable string
--- @return function
function focus_or_launch(initial_class, executable)
	return function()
		local windows = hl.get_windows()
		for _, w in ipairs(windows) do
			if w.initial_class == initial_class then
				hl.dispatch(hl.dsp.focus({ window = w }))
				return
			end
		end
    hl.exec_cmd(executable)
	end
end
