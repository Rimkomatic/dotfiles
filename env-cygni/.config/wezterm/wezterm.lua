local wezterm = require("wezterm")

wezterm.on(
	'window-focus-changed',
	function(window, pane)
		wezterm.run_child_process { 'sh', '-c', 'wl-paste -n | wl-copy' }
	end
)

local config = wezterm.config_builder()

config.automatically_reload_config = true
config.enable_tab_bar = false
config.max_fps = 120
config.enable_wayland = true 
config.use_dead_keys = false
config.window_close_confirmation = "NeverPrompt"
config.default_cursor_style = "SteadyBlock"
config.cursor_blink_ease_out = "Constant"
config.cursor_blink_ease_in = "Constant"
config.cursor_blink_rate = 0
config.color_scheme = "Argonaut"
config.font = wezterm.font_with_fallback({
  "JetBrainsMono Nerd Font",
  "Fira Code",
  "Monaco",
})
config.font_size = 12
config.colors = {
  cursor_fg = "black",
}

-- config.keys = {
--   {
--     key = "V",
--     mods = "CTRL|SHIFT",
--     action = wezterm.action.PasteFrom("Clipboard"),
--   },
-- }
-- Background with blur
config.background = {
  {
    source = {
      Color = "#000000",
    },
    width = "100%",
    height = "100%",
    opacity =0.65
    -- blur = 20.0, -- Adjust between 10–30 for subtle to heavy blur
  },
}

-- Optional: overall window transparency
-- config.window_background_opacity = 0.8

return config

