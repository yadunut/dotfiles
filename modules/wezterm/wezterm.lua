local wezterm = require 'wezterm'

local config = wezterm.config_builder()

local font = wezterm.font({family = "Comic Mono"})

config.front_end = "WebGpu"

config.font = font
config.font_size = 13
config.window_decorations = "RESIZE"
config.window_frame = {
  font = font,
  font_size = 14,
}

config.hide_tab_bar_if_only_one_tab = true
config.tab_bar_at_bottom = false

-- set theme based on system appearance
function get_appearance()
  if wezterm.gui then
    return wezterm.gui.get_appearance()
  end
  return 'Dark'
end

function scheme_for_appearance(appearance)
  if appearance:find 'Dark' then
    return 'Gruvbox Dark (Gogh)'
  else
    return 'Gruvbox (Gogh)'
  end
end

config.color_scheme = scheme_for_appearance(get_appearance())

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
  {
    key = ">",
    mods = "LEADER",
    action = wezterm.action.MoveTabRelative(1)
  },
  {
    key = "<",
    mods = "LEADER",
    action = wezterm.action.MoveTabRelative(-1)
  },
}

local function get_current_working_dir(tab)
  local current_dir = tab.active_pane and tab.active_pane.current_working_dir or { file_path = '' }
  local HOME_DIR = os.getenv('HOME')

  return current_dir.file_path == HOME_DIR and '~'
    or string.gsub(current_dir.file_path, '(.*[/\\])(.*)', '%2')
end

-- wezterm.on('format-tab-title', function(tab, tabs, panes, config, hover, max_width)
--   local has_unseen_output = false
--   if not tab.is_active then
--     for _, pane in ipairs(tab.panes) do
--       if pane.has_unseen_output then
--         has_unseen_output = true
--         break
--       end
--     end
--   end
--
--    local cwd = wezterm.format({
--     { Text = get_current_working_dir(tab) },
--   })
--
--   local process = get_process(tab)
--   local title = process and string.format(' %s (%s) ', process, cwd) or ' [?] '
--
--   if has_unseen_output then
--     return {
--       { Foreground = { Color = '#28719c' } },
--       { Text = title },
--     }
--   end
--
--   return {
--     { Text = title },
--   }
-- end)

return config
