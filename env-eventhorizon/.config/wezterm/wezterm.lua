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
config.color_scheme = "Noctalia"
-- config.color_scheme = "xen"
config.font = wezterm.font_with_fallback({
  "JetBrainsMono Nerd Font",
  "Fira Code",
  "Monaco",
})
config.font_size = 10
config.colors = {
  cursor_fg = "black",
}

config.background = {
  {
    source = {
      Color = "#000000",
    },
    width = "100%",
    height = "100%",
    opacity =0.65
  },
}

config.keys = {
    {
      key = "d",
      mods = "CTRL|SHIFT",
      action = wezterm.action.SplitHorizontal { domain = "CurrentPaneDomain" },
    },
    {
      key = "d",
      mods = "CTRL|ALT",
      action = wezterm.action.SplitVertical { domain = "CurrentPaneDomain" },
    },

    {
      key = "t",
      mods = "CTRL|SHIFT",
      action = wezterm.action.SpawnTab("CurrentPaneDomain"),
    },
  }

  config.colors={
      -- selection_bg = "#d70022",
      -- selection_fg = "#000000",

      cursor_bg = "#d70022",
      cursor_fg = "#000000",
      cursor_border = "#d70022",
  }



return config

