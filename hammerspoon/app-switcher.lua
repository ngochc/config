-- ------------------------------------------------------------
-- App Switcher
-- AltTab-style app switcher with single-key shortcuts
-- ------------------------------------------------------------

local App = require("Custom/AppSwitcher/app")

local AppSwitcher = {
	hotkeys = {},
	apps = {},
	len = 0,
	visible = false,
}

function AppSwitcher:new(o)
	local switcher = o or {}
	setmetatable(switcher, self)
	self.__index = self

	switcher.dismissBinding = hs.hotkey.new(nil, "escape", function()
		switcher:hide()
	end)

	local keys = "abcdefghijklmnopqrstuvwxyz"
	for key in keys:gmatch(".") do
		switcher.hotkeys[key] = false
	end

	for _, app in pairs(hs.application.runningApplications()) do
		if app:kind() == 1 then
			switcher:addApp(app)
		end
	end

	hs.application.watcher
		.new(function(_, eventType, app)
			if app:kind() ~= 1 then
				return
			elseif eventType == hs.application.watcher.launching then
				switcher:addApp(app)
			elseif eventType == hs.application.watcher.terminated then
				switcher:removeApp(app)
			end
		end)
		:start()

	return switcher
end

function AppSwitcher:addApp(app)
	local id = app:bundleID()
	if self.apps[id] ~= nil then
		return
	end

	local hotkey = self:getHotkey(app:title())

	self.apps[id] = App:new({
		hotkey = hotkey,
		hsApp = app,
		onTrigger = function()
			self:hide()
		end,
	})

	self.hotkeys[hotkey] = true
	self.len = self.len + 1
end

function AppSwitcher:removeApp(app)
	local id = app:bundleID()
	if self.apps[id] == nil then
		return
	end

	self.apps[id]:destroy()
	self.hotkeys[self.apps[id].hotkey] = false
	self.apps[id] = nil
	self.len = self.len - 1
end

function AppSwitcher:getHotkey(appName)
	local index = 1
	local hotkey = nil

	while hotkey == nil do
		hotkey = string.lower(string.sub(appName, index, index))

		if hotkey == "" then
			for key, used in pairs(self.hotkeys) do
				if not used then
					return key
				end
			end
		end

		if self.hotkeys[hotkey] then
			hotkey = nil
			index = index + 1
		end
	end

	return hotkey
end

function AppSwitcher:show()
	if self.visible then
		if self.dismissTimer then
			self.dismissTimer:stop()
			self.dismissTimer:start()
		end
		return
	end

	self.visible = true
	local frame = hs.screen.mainScreen():frame()
	local itemWidth = 120
	local itemHeight = 120
	local padding = 12
	local width = (itemWidth + padding) * self.len + padding
	local maxWidth = frame.w - 40
	if width > maxWidth then
		width = maxWidth
	end
	local height = itemHeight + (padding * 2)

	self.overlay = hs.canvas.new({
		x = 0,
		y = 0,
		w = frame.w,
		h = frame.h,
	})
	self.overlay:appendElements({
		type = "rectangle",
		action = "fill",
		fillColor = { red = 0, green = 0, blue = 0, alpha = 0.35 },
		frame = { x = 0, y = 0, w = frame.w, h = frame.h },
	})
	self.overlay:show()

	self.canvas = hs.canvas.new({
		x = (frame.w / 2) - (width / 2),
		y = (frame.h / 2) - (height / 2),
		h = height,
		w = width,
	})

	if self.canvas == nil then
		error("AppSwitcher: Could not create hs.canvas")
	end

	self.canvas:appendElements({
		type = "rectangle",
		action = "fill",
		fillColor = { red = 0.1, green = 0.1, blue = 0.12, alpha = 0.95 },
		roundedRectRadii = { xRadius = 18, yRadius = 18 },
		frame = { x = 0, y = 0, w = width, h = height },
	}, {
		type = "rectangle",
		action = "stroke",
		strokeColor = { red = 0.5, green = 0.5, blue = 0.6, alpha = 0.25 },
		strokeWidth = 1,
		roundedRectRadii = { xRadius = 18, yRadius = 18 },
		frame = { x = 0, y = 0, w = width, h = height },
	})

	self.dismissTimer = hs.timer.doAfter(3, function()
		self:hide()
	end)
	self.dismissBinding:enable()

	local x = padding
	for _, app in pairs(self.apps) do
		app:enableSingleKeyBinding()

		local elements = app:getUI(x, padding, itemWidth, itemHeight)
		for _, element in ipairs(elements) do
			self.canvas:appendElements(element)
		end

		x = x + itemWidth + padding
	end

	self.canvas:show()
end

function AppSwitcher:hide()
	if self.canvas then
		self.canvas:delete(0.1)
	end
	if self.overlay then
		self.overlay:delete(0.1)
		self.overlay = nil
	end
	self.dismissBinding:disable()
	if self.dismissTimer then
		self.dismissTimer:stop()
	end
	for _, app in pairs(self.apps) do
		app:disableSingleKeyBinding()
	end
	self.visible = false
end

local as = AppSwitcher:new({})

hs.hotkey.bind("option", "tab", function()
	as:show()
end)
