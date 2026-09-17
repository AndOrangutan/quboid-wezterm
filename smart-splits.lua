_M = {}

local wezterm = require('wezterm')

-- IS_NVIM is set by smart-splits.nvim. Process name is a fallback; it is
-- often nil, and calling `:find` on nil used to abort the keybind.
local function is_vim(pane)
    if pane:get_user_vars().IS_NVIM == 'true' then
        return true
    end
    local proc = pane:get_foreground_process_name()
    if not proc or proc == '' then
        return false
    end
    local name = proc:match('[^/\\]+$') or proc
    return name == 'nvim' or name == 'vim'
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
            local num_panes = #win:active_tab():panes()
            if is_vim(pane) or num_panes == 1 then
                win:perform_action({
                    SendKey = { key = key, mods = modifier },
                }, pane)
            elseif resize_or_move == 'resize' then
                win:perform_action({ AdjustPaneSize = { direction_keys[key], 3 } }, pane)
            else
                win:perform_action({ ActivatePaneDirection = direction_keys[key] }, pane)
            end
        end),
    }
end

return _M
