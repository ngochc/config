-- ------------------------------------------------------------
-- Display Movement
-- Move windows between displays
-- ------------------------------------------------------------

local config = require("config")
local hyper = config.hyper
local focused = config.focused

local function moveToScreen(win, next)
	if not win then
		return
	end
	local scr = next and win:screen():next() or win:screen():previous()
	win:moveToScreen(scr, false, true) -- keep size, no animation
end

hs.hotkey.bind(hyper, "N", function()
	moveToScreen(focused(), true)
end)
