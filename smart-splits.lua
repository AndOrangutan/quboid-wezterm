_M = {}

local wezterm = require('wezterm')

local function is_vim(pane)
    -- This checks for the IS_NVIM var set by the plugin
    -- Or falls back to checking the process name
    return pane:get_user_vars().IS_NVIM == 'true' or
    pane:get_foreground_process_name():find('n?vim') ~= nil
end

local direction_keys = {
    h = 'Left',
    j = 'Down',
    k = 'Up',
    l = 'Right',
}

_M.split_nav = function(resize_or_move, key)
    local modifier = resize_or_move == 'resize' and 'CTRL|ALT' or 'ALT'
    return {
        key = key,
        mods = modifier,
        action = wezterm.action_callback(function(win, pane)
            if is_vim(pane) then
                -- Pass the keys through to Neovim
                win:perform_action({
                    SendKey = { key = key, mods = modifier },
                }, pane)
            else
                -- Native Wezterm split navigation/resize
                if resize_or_move == 'resize' then
                    win:perform_action({ AdjustPaneSize = { direction_keys[key], 3 } }, pane)
                else
                    win:perform_action({ ActivatePaneDirection = direction_keys[key] }, pane)
                end
            end
        end),
    }
end

return _M
