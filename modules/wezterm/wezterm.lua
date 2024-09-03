local wezterm = require 'wezterm'

local config = wezterm.config_builder()

local font = wezterm.font({family = "Comic Mono"})

config.front_end = "WebGpu"

config.color_scheme = "Gruvbox Dark (Gogh)"
config.font = font
config.font_size = 13
config.window_decorations = "RESIZE|INTEGRATED_BUTTONS"
config.window_frame = {
    font = font,
    font_size = 14,
}

config.hide_tab_bar_if_only_one_tab = true
config.tab_bar_at_bottom = true

wezterm.on('update-status', function(window)
    local SOLID_LEFT_ARROW = utf8.char(0xe0b2)
    local color_scheme = window:effective_config().resolved_palette
    local bg = color_scheme.background
    local fg = color_scheme.foreground

    window:set_right_status(wezterm.format({
        { Background = { Color = 'none' }},
        { Foreground = { Color = bg }},
        { Text = SOLID_LEFT_ARROW },

        { Background = { Color = bg }},
        { Foreground = { Color = fg }},
        { Text = ' ' .. wezterm.hostname() .. ' ' },
    }))
end)

config.leader = { key = 'a', mods = 'CTRL', timeout_milliseconds = 1000 }

function nav_pane(key, dir)
    return {
        key = key,
        mods = "LEADER",
        action = wezterm.action.ActivatePaneDirection(dir),
    }
end

config.keys = {
    {
        key = "\\",
        mods = "LEADER",
        action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' }
    },
    {
        key = "-",
        mods = "LEADER",
        action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' }
    },
    nav_pane("h", "Left"),
    nav_pane("j", "Down"),
    nav_pane("k", "Up"),
    nav_pane("l", "Right"),
}

return config
