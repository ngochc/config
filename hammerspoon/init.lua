-- ------------------------------------------------------------
-- Hammerspoon Configuration
-- Main entry point - loads all modules
-- ------------------------------------------------------------

-- Load shared configuration first
require("config")

-- Load modules
-- require("app-switcher")      -- AltTab replacement
require("window-basic") -- Basic window management (halves, corners, maximize, center)
require("window-display") -- Display movement
require("window-grid") -- Visual grid
require("app-launcher") -- App launcher/focus shortcuts
require("app-switcher") -- App switcher shortcuts
