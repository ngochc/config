-- ------------------------------------------------------------
-- Visual Grid
-- Show grid overlay for window positioning
-- ------------------------------------------------------------

local config = require("config")
local hyper = config.hyper
local GAP = config.GAP

hs.grid.setMargins(hs.geometry.size(GAP, GAP))
hs.grid.setGrid("6x4")
hs.hotkey.bind(hyper, "M", function()
	hs.grid.show()
end)
