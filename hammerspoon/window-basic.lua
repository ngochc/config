-- ------------------------------------------------------------
-- Basic Window Management
-- Halves, Corners, Maximize, Center
-- ------------------------------------------------------------

local config = require("config")
local hyper = config.hyper
local moveFrac = config.moveFrac
local focused = config.focused
local screenFrame = config.screenFrame

-- Halves (Hyper+Arrows)
hs.hotkey.bind(hyper, "H", function()
	local w = focused()
	if w then
		moveFrac(w, 0, 0, 0.5, 1)
	end
end)
hs.hotkey.bind(hyper, "L", function()
	local w = focused()
	if w then
		moveFrac(w, 0.5, 0, 0.5, 1)
	end
end)

-- Maximize / Center (Hyper+Return / Hyper+C)
hs.hotkey.bind(hyper, "J", function()
	local w = focused()
	if not w then
		return
	end
	local f = screenFrame(w)
	w:setFrame(f)
end)

hs.hotkey.bind(hyper, "K", function()
	local w = focused()
	if not w then
		return
	end
	local f = screenFrame(w)
	local ww = f.w * 0.62
	w:setFrame(hs.geometry.rect(f.x + (f.w - ww) / 2, 0, ww, f.h))
end)
