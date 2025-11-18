local hyper = { "ctrl", "alt", "cmd", "shift" }
local GAP = 1

local function screenFrame(win)
	local s = win:screen():frame()
	return hs.geometry.rect(s.x + GAP, s.y + GAP, s.w - 2 * GAP, s.h - 2 * GAP)
end

local function moveFrac(win, x, y, w, h)
	local f = screenFrame(win)
	win:setFrame(hs.geometry.rect(f.x + f.w * x, f.y + f.h * y, f.w * w, f.h * h))
end

local function focused()
	return hs.window.frontmostWindow()
end

return {
	hyper = hyper,
	defaultMod = hyper,
	GAP = GAP,
	screenFrame = screenFrame,
	moveFrac = moveFrac,
	focused = focused,
}
