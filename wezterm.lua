local wezterm = require('wezterm')
local config = wezterm.config_builder()

-- https://wezterm.org/colorschemes/index.html
config.color_scheme = 'OneDark (base16)'

config.font = wezterm.font('Fantasque Sans Mono')
config.font_size = 14.0
-- config.window_background_opacity = 0.95

config.check_for_updates = false
config.hide_tab_bar_if_only_one_tab = true

return config
