-- Import the wezterm module
local wezterm = require 'wezterm'
-- Creates a config object which we will be adding our config to
local config = wezterm.config_builder()

-- See: https://alexplescan.com/posts/2024/08/10/wezterm/

local appearance = require 'appearance'

-- Spawn a fish shell in login mode
config.default_prog = { '/opt/homebrew/bin/fish', '-l' }

if appearance.is_dark() then
  config.color_scheme = 'Selenized Dark (Gogh)'
else
  config.color_scheme = 'Selenized Light (Gogh)'
end

-- Table mapping keypresses to actions
config.keys = {
  -- Sends ESC + b and ESC + f sequence, which is used
  -- for telling your shell to jump back/forward.
  {
    -- When the left arrow is pressed
    key = 'LeftArrow',
    -- With the "Option" key modifier held down
    mods = 'OPT',
    -- Perform this action, in this case - sending ESC + B
    -- to the terminal
    action = wezterm.action.SendString '\x1bb',
  },
  {
    key = 'RightArrow',
    mods = 'OPT',
    action = wezterm.action.SendString '\x1bf',
  },
}

return config
