local wezterm = require("wezterm")

-- ==========================================
-- THEME CYCLER LOGIC
-- ==========================================
local schemes = wezterm.get_builtin_color_schemes()
local scheme_names = {}
for name, _ in pairs(schemes) do
  table.insert(scheme_names, name)
end
table.sort(scheme_names)

wezterm.on('cycle-theme', function(window, pane)
  local overrides = window:get_config_overrides() or {}
  -- Get the current theme from overrides or fallback to the config's base scheme
  local current_scheme = overrides.color_scheme or window:effective_config().color_scheme
  
  local current_idx = 1
  for i, name in ipairs(scheme_names) do
    if name == current_scheme then
      current_idx = i
      break
    end
  end
  
  local next_idx = current_idx + 1
  if next_idx > #scheme_names then
    next_idx = 1
  end
  
  local next_scheme = scheme_names[next_idx]
  
  overrides.color_scheme = next_scheme
  window:set_config_overrides(overrides)
  
  window:toast_notification('WezTerm Theme', 'Switched to: ' .. next_scheme, nil, 4000)
end)
-- ==========================================

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


config.color_scheme_dirs = {
  wezterm.config_dir .. "/colors"
}

-- config.color_scheme = "Argonaut"
-- config.color_scheme = 'Scarlet Protocol'
-- config.color_scheme = 'Sea Shells (Gogh)'
-- config.color_scheme = 'Sequoia Moonlight'
-- config.color_scheme = "Noctalia"
config.color_scheme = 'custom'
config.font = wezterm.font_with_fallback({
  "JetBrainsMono Nerd Font",
  "Fira Code",
  "Monaco",
})
config.font_size = 12
-- config.colors = {
--   cursor_fg = "black",
-- }

-- Background with blur
config.background = {
  {
    source = {
      Color = "#000000",
    },
    width = "100%",
    height = "100%",
    opacity = 0.65
    -- blur = 20.0, -- Adjust between 10–30 for subtle to heavy blur
  },
}

-- Optional: overall window transparency
-- config.window_background_opacity = 0.8

-- ==========================================
-- KEY BINDINGS
-- ==========================================
config.keys = {
--   {
--     key = "V",
--     mods = "CTRL|SHIFT",
--     action = wezterm.action.PasteFrom("Clipboard"),
--   },
  { 
    key = 'T', 
    mods = 'CTRL|SHIFT', 
    action = wezterm.action.EmitEvent 'cycle-theme' 
  },
}

return config
