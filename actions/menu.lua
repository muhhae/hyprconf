return {
  Omarchy = hl.dsp.exec_cmd("omarchy-menu"), -- need to be replaced at somepoint
	App = hl.dsp.exec_cmd("walker"),
	System = function()
		local options = {
			"󱄄  Screensaver",
			"  Lock",
			"󰒲  Suspend",
			"󰤁  Hibernate",
			"󰍃  Logout",
			"󰜉  Restart",
			"󰐥  Shutdown",
		}
		local str_options = table.concat(options, "\n")
		exec_cmd_with_callback("echo " .. '"' .. str_options .. '"' .. "| walker --dmenu", function(selected)
			hl.notification.create({ text = selected, duration = "3000" })
		end)
	end,
}
