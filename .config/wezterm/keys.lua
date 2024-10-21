local wezterm = require('wezterm')
local act = wezterm.action

return {
  { key = 'h', mods = 'CTRL|SHIFT', action = act.ActivateTabRelative(-1) },
  { key = 'l', mods = 'CTRL|SHIFT', action = act.ActivateTabRelative(1) },
  { key = 'k', mods = 'CTRL|SHIFT', action = act.ScrollByLine(-1) },
  { key = 'j', mods = 'CTRL|SHIFT', action = act.ScrollByLine(1) },
  { key = 'q', mods = 'CTRL|SHIFT', action = act.CloseCurrentTab({ confirm = true }) },
  { key = 'c', mods = 'CTRL|SHIFT', action = act.CopyTo("Clipboard") },
  { key = 'v', mods = 'CTRL|SHIFT', action = act.PasteFrom("Clipboard") },
  { key = 'n', mods = 'CTRL|SHIFT', action = act.ScrollByLine(1) },
  { key = '+', mods = 'CTRL|SHIFT', action = act.IncreaseFontSize },
  { key = '_', mods = 'CTRL|SHIFT', action = act.DecreaseFontSize },
  { key = 'p', mods = 'CTRL|SHIFT', action = act.ActivateCommandPalette },
  { key = 'n', mods = 'CTRL|SHIFT', action = act.SpawnTab("DefaultDomain") },
  { key = 'PageUp', mods = 'CTRL|SHIFT', action = act.ScrollByPage(-1) },
  { key = 'PageDown', mods = 'CTRL|SHIFT', action = act.ScrollByPage(1) },
}
