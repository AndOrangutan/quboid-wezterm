local wezterm = require('wezterm')
local config = wezterm.config_builder()

local smart = require('smart-splits')

-- https://wezterm.org/colorschemes/index.html
config.color_scheme = 'OneDark (base16)'

config.font = wezterm.font('Fantasque Sans Mono')
config.font_size = 14.0
-- config.window_background_opacity = 0.95

config.check_for_updates = false
config.hide_tab_bar_if_only_one_tab = true

config.keys = {
    -- Move between split panes: Alt + h/j/k/l
    smart.split_nav('move', 'h'),
    smart.split_nav('move', 'j'),
    smart.split_nav('move', 'k'),
    smart.split_nav('move', 'l'),
    -- Resize panes: Ctrl + Alt + h/j/k/l
    smart.split_nav('resize', 'h'),
    smart.split_nav('resize', 'j'),
    smart.split_nav('resize', 'k'),
    smart.split_nav('resize', 'l'),
}
return config
