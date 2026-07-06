require("styles.windowrules")
require("styles.scrolling")

hl.config({
	general = {
		gaps_in = 8,
		gaps_out = 8,
		border_size = 0,
		resize_on_border = false,
		allow_tearing = false,
		layout = "scrolling",
	},

	decoration = {
		dim_inactive = true,
		rounding = 4,
		rounding_power = 2,
		active_opacity = 1.0,
		inactive_opacity = 1.0,
		shadow = {
			enabled = false,
			range = 4,
			render_power = 3,
			color = 0xee1a1a1a,
		},
		blur = {
			enabled = true,
			size = 2,
			passes = 3,
			-- vibrancy = 0.1696,
			vibrancy = 0.5,
			-- xray = true,
		},
	},
	animations = {
		enabled = true,
	},
})
