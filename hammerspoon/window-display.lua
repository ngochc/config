-- ------------------------------------------------------------
-- Display Movement
-- Move windows between displays
-- ------------------------------------------------------------

local config = require("config")
local hyper = config.hyper
local focused = config.focused

-- Move to next/previous display (Hyper+Right/Left)
local function moveToScreen(win, next)
	if not win then
		return
	end
	local scr = next and win:screen():next() or win:screen():previous()
	win:moveToScreen(scr, false, true) -- keep size, no animation
end

hs.hotkey.bind(hyper, "Right", function()
	moveToScreen(focused(), true)
end)
hs.hotkey.bind(hyper, "Left", function()
	moveToScreen(focused(), false)
end)

