-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices.

-- For example, changing the initial geometry for new windows:
config.initial_cols = 100
config.initial_rows = 28

-- or, changing the font size and color scheme.
config.font_size = 15
-- config.font = wezterm.font("MonaspiceAr Nerd Font", { weight = "Medium" })
config.font = wezterm.font("MonaspiceAr Nerd Font", { weight = "Regular" })
config.line_height = 1.2
-- config.color_scheme = "Desert (Gogh)"
config.color_scheme = "Dracula (Official)"

-- Only on MacOS / Linux
-- config.use_resize_increments = true
-- OpenGL does not work well on MacOS
config.front_end = "WebGpu"

-- 2. Custom Startup Layout
wezterm.on("gui-startup", function(cmd)
	-- Create the window and the "Primary" Tab (Single pane)
	local tab1, pane1, window = wezterm.mux.spawn_window(cmd or {})
	tab1:set_title("Primary")

	-- Create the "Secondary" Tab
	local tab2, pane2, _ = window:spawn_tab(cmd or {})
	tab2:set_title("Secondary")

	-- Split the "Secondary" Tab horizontally (creates Top and Down panes)
	pane2:split({
		direction = "Top",
		size = 0.5,
	})

	-- Bring focus back to the Primary Tab on startup
	tab1:activate()
end)

-- Finally, return the configuration to wezterm:
return config
