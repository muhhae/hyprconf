hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")
hl.env("TERMINAL", "ghostty")

local current_path = os.getenv("PATH")
local current_home = os.getenv("HOME")
hl.env("PATH", current_path .. ":/" .. current_home .. "/omarchy/bin")
