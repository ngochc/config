---@diagnostic disable: undefined-field

local wt = require "wezterm"
local fs = require("utils.fn").fs

local Config = {}

Config.adjust_window_size_when_changing_font_size = false
Config.allow_square_glyphs_to_overflow_width = "WhenFollowedBySpace"
Config.anti_alias_custom_block_glyphs = true

Config.font = wt.font_with_fallback {
  {
    family = "JetBrainsMono Nerd Font",
    weight = "Regular",
  },
  { family = "Noto Color Emoji" },
  { family = "LegacyComputing" },
}

Config.font_size = 13

Config.underline_position = -2.5
Config.underline_thickness = "2px"
Config.warn_about_missing_glyphs = false

local monaspace_features =
  { "dlig", "ss01", "ss02", "ss03", "ss04", "ss05", "ss06", "ss07", "ss08" }

Config.font_rules = {}

return Config
