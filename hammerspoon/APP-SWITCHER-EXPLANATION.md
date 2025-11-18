# App Switcher Code Explanation

This is a custom AltTab-style app switcher that shows running applications with single-key shortcuts.

## Overview

The code creates a visual app switcher that:
1. Shows all running applications in a grid
2. Assigns each app a single letter key (a-z)
3. Lets you switch to an app by pressing its letter key
4. Auto-hides after 3 seconds or when Escape is pressed

## Code Breakdown

### 1. Class Definition (Lines 3-16)

```lua
local AppSwitcher = {
    hotkeys = {},      -- Tracks which letters (a-z) are assigned
    apps = {},         -- Stores App objects by bundle ID
    len = 0,           -- Number of apps currently tracked
    visible = false,   -- Whether switcher is currently shown
}
```

**Purpose**: Defines the AppSwitcher class structure with:
- `hotkeys`: Tracks which letters (a-z) are already assigned to apps
- `apps`: Dictionary of App objects, keyed by bundle ID
- `len`: Count of apps
- `visible`: Whether the switcher UI is currently displayed

### 2. Constructor (Lines 18-56)

```lua
function AppSwitcher:new(o)
```

**What it does:**
1. **Creates dismiss binding** (line 24-26): Binds Escape key to hide the switcher
2. **Initializes hotkey tracking** (lines 28-32): Sets up all 26 letters (a-z) as available
3. **Loads running apps** (lines 34-39): Finds all apps currently running and adds them
4. **Sets up app watcher** (lines 43-53): Watches for apps launching/terminating to update the list

**Key details:**
- `app:kind() == 1` means the app is in the Dock (regular app, not background process)
- The watcher automatically adds new apps when they launch
- The watcher removes apps when they terminate

### 3. Add App (Lines 59-77)

```lua
function AppSwitcher:addApp(app)
```

**What it does:**
1. Gets the app's bundle ID (unique identifier)
2. Skips if app already exists
3. **Assigns a hotkey** using `getHotkey()` - tries to use the first letter of the app name
4. Creates an App object with the assigned hotkey
5. Marks the hotkey as used
6. Increments the app count

**Example:**
- "Safari" → gets hotkey "s"
- "Google Chrome" → gets hotkey "g"
- If "g" is taken, tries next letter "o", then "o" (duplicate), then "l", etc.

### 4. Remove App (Lines 80-91)

```lua
function AppSwitcher:removeApp(app)
```

**What it does:**
1. Finds the app by bundle ID
2. Destroys the App object (cleans up hotkeys)
3. Frees the hotkey letter
4. Removes from apps dictionary
5. Decrements the count

### 5. Get Hotkey (Lines 94-117)

```lua
function AppSwitcher:getHotkey(appName)
```

**Smart hotkey assignment algorithm:**

1. **Try first letter** of app name (e.g., "Safari" → "s")
2. **If taken**, try second letter (e.g., "Google Chrome" → "g" taken, try "o")
3. **Continue** through letters until finding an unused one
4. **If all letters used**, find any unused letter from a-z

**Example flow:**
- "Safari" → "s" (available) ✓
- "Slack" → "s" (taken), try "l" (available) ✓
- "Spotify" → "s" (taken), try "p" (available) ✓
- "System Preferences" → "s" (taken), try "y" (available) ✓

### 6. Show Switcher (Lines 119-157)

```lua
function AppSwitcher:show()
```

**What it does:**

1. **If already visible**: Reset the 3-second timer
2. **Calculate layout**: 
   - Each app item is 110px wide
   - Total width = 110px × number of apps
   - Centers on screen
3. **Create canvas**: Creates a visual overlay to display apps
4. **Set auto-dismiss**: Hides after 3 seconds
5. **Enable Escape binding**: Allows Escape to dismiss
6. **Draw app items**: Adds each app's UI element to the canvas
7. **Show canvas**: Displays the switcher

**Visual layout:**
```
┌─────┬─────┬─────┬─────┐
│ App │ App │ App │ App │  Each 110px wide
│  a  │  s  │  d  │  f  │  Shows letter key
└─────┴─────┴─────┴─────┘  Centered on screen
```

### 7. Hide Switcher (Lines 159-167)

```lua
function AppSwitcher:hide()
```

**What it does:**
1. Deletes the canvas (with 0.1s fade animation)
2. Disables Escape binding
3. Stops the auto-dismiss timer
4. Disables all app hotkeys
5. Sets visible to false

### 8. Initialization & Binding (Lines 169-174)

```lua
local as = AppSwitcher:new({})
hs.hotkey.bind("option", "tab", function()
    as:show()
end)
```

**What it does:**
1. Creates a new AppSwitcher instance
2. Binds **⌥ Tab** (Option + Tab) to show the switcher

## How It Works

### User Flow:

1. **Press ⌥ Tab** → Switcher appears
2. **See apps** with letter keys displayed
3. **Press a letter** (e.g., "s" for Safari) → Switches to that app
4. **Or press Escape** → Dismisses switcher
5. **Or wait 3 seconds** → Auto-dismisses

### Example:

```
Apps running: Safari, Slack, Chrome, VS Code
Hotkeys assigned: s, l, c, v

Press ⌥ Tab:
┌─────┬─────┬─────┬─────┐
│ Safari│Slack│Chrome│VS Code│
│   s   │  l  │  c  │   v   │
└─────┴─────┴─────┴─────┘

Press "s" → Switches to Safari
Press "l" → Switches to Slack
Press Escape → Dismisses switcher
```

## Key Features

1. **Smart hotkey assignment**: Uses app name letters when possible
2. **Auto-updates**: Watches for app launches/terminations
3. **Visual feedback**: Shows which key to press for each app
4. **Auto-dismiss**: Hides after 3 seconds
5. **Escape to cancel**: Quick way to dismiss

## Dependencies

Requires `Custom/AppSwitcher/app.lua` which provides:
- `App:new()` - Creates App objects
- `app:enableSingleKeyBinding()` - Enables the letter key binding
- `app:disableSingleKeyBinding()` - Disables the binding
- `app:getUI()` - Returns UI elements for canvas
- `app:destroy()` - Cleans up the App object

## Potential Issues

If the code doesn't work, check:
1. Does `Custom/AppSwitcher/app.lua` exist?
2. Are all required functions implemented in the App class?
3. Check Hammerspoon console for errors

