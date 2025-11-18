-- ------------------------------------------------------------
-- App Launcher / Focus
-- Quick shortcuts to launch or focus applications
-- ------------------------------------------------------------

local config = require("config")
local hyper = config.hyper

local function launchOrFocus(appName)
	return function()
		hs.application.launchOrFocus(appName)
	end
end

hs.hotkey.bind(hyper, "A", launchOrFocus("Visual Studio Code"))
hs.hotkey.bind(hyper, "S", launchOrFocus("Slack"))
hs.hotkey.bind(hyper, "D", launchOrFocus("Google Chrome"))
hs.hotkey.bind(hyper, "F", launchOrFocus("WezTerm"))
hs.hotkey.bind(hyper, "G", launchOrFocus("Safari"))
hs.hotkey.bind(hyper, "V", launchOrFocus("IntelliJ IDEA"))
