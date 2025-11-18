---@class App
---@field hotkey string
---@field icon hs.image
---@field hsApp hs.application
---@field directBinding hs.hotkey
---@field singleKeyBinding hs.hotkey
---@field onTrigger function

local config = require("config")
local defaultMod = config.defaultMod or config.hyper

local App = {
    hotkey = "",
}

function App:new(o)
    o = o or {}
    setmetatable(o, self)
    self.__index = self

    o.directBinding = hs.hotkey.bind(defaultMod, o.hotkey, function()
        o:activate()
    end)

    o.singleKeyBinding = hs.hotkey.new(nil, o.hotkey, function()
        o:activate()
        if o.onTrigger then
            o.onTrigger()
        end
    end)

    local id = o.hsApp:bundleID()
    if id == nil then
        o.icon = hs.image.imageFromName("ApplicationIcon")
    else
        o.icon = hs.image.imageFromAppBundle(id)
        if o.icon == nil then
            o.icon = hs.image.imageFromName("ApplicationIcon")
        end
    end

    return o
end

function App:enableSingleKeyBinding()
    self.singleKeyBinding:enable()
end

function App:disableSingleKeyBinding()
    self.singleKeyBinding:disable()
end

function App:activate()
    hs.application.launchOrFocusByBundleID(self.hsApp:bundleID())
end

function App:destroy()
    self.singleKeyBinding:delete()
    self.directBinding:delete()
end

function App:getUI(x, y, w, h)
    local padding = 10
    local badgeSize = 56
    local iconHeight = h - badgeSize - (padding * 3)
    if iconHeight < 40 then
        iconHeight = 40
    end
    local iconWidth = w - (padding * 2)

    local elements = {}

    -- App card background
    table.insert(elements, {
        type = "rectangle",
        action = "fill",
        fillColor = { red = 0.18, green = 0.18, blue = 0.2, alpha = 0.95 },
        roundedRectRadii = { xRadius = 16, yRadius = 16 },
        frame = { x = x, y = y, w = w, h = h },
    })

    -- Letter badge background
    local badgeX = x + (w - badgeSize) / 2
    table.insert(elements, {
        type = "rectangle",
        action = "fill",
        fillColor = { red = 0.35, green = 0.35, blue = 0.4, alpha = 0.9 },
        roundedRectRadii = { xRadius = 10, yRadius = 10 },
        frame = { x = badgeX, y = y + padding, w = badgeSize, h = badgeSize },
    })

    -- Letter badge text
    table.insert(elements, {
        type = "text",
        frame = { x = badgeX, y = y + padding, w = badgeSize, h = badgeSize },
        text = hs.styledtext.new(string.upper(self.hotkey), {
            font = { name = ".AppleSystemUIFont", size = 34, weight = "bold" },
            paragraphStyle = { alignment = "center" },
            color = { alpha = 1, red = 1, green = 1, blue = 1 },
        }),
        textAlignment = "center",
    })

    -- App icon
    table.insert(elements, {
        type = "image",
        image = self.icon,
        frame = {
            x = x + padding,
            y = y + padding * 2 + badgeSize,
            w = iconWidth,
            h = iconHeight,
        },
        imageAlignment = "center",
        imageScaling = "scaleProportionallyUpOrDown",
    })

    return elements
end

return App
