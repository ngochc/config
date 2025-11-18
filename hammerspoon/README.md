# Hammerspoon Configuration

This Hammerspoon configuration provides an AltTab replacement and Rectangle-style window management with cycling capabilities.

## File Structure

The configuration is organized into multiple files by category:

- **`init.lua`** - Main entry point that loads all modules
- **`config.lua`** - Shared configuration (hyper key, GAP, utility functions)
- **`app-switcher.lua`** - AltTab replacement functionality
- **`window-basic.lua`** - Basic window management (halves, corners, maximize, center)
- **`window-display.lua`** - Display movement between screens
- **`window-cycling.lua`** - Thirds cycling (horizontal and vertical)
- **`window-grid.lua`** - Visual grid overlay
- **`app-launcher.lua`** - App launcher/focus shortcuts

## Window Switching (AltTab Replacement)

### Application Switching
- **⌘ ⇧ Tab** - Switch to previous application window
- **⌥ Tab** - Switch to next application window
- **⌥ ⇧ Tab** - Switch to previous application window

**Note:** ⌘ Tab is commented out in the config (to keep macOS's default switcher). Within-app window cycling (⌘`) is also commented out.

## Window Management

All window management shortcuts use **⌃ ⌥ ⌘ ⇧** (Control + Option + Command + Shift) as the modifier key (Hyper key).

### Halves
- **⌃ ⌥ ⌘ ⇧ ←** - Move window to left half
- **⌃ ⌥ ⌘ ⇧ →** - Move window to right half
- **⌃ ⌥ ⌘ ⇧ ↑** - Move window to top half
- **⌃ ⌥ ⌘ ⇧ ↓** - Move window to bottom half

### Corners
- **⌃ ⌥ ⌘ ⇧ U** - Move window to top-left corner (quarter)
- **⌃ ⌥ ⌘ ⇧ I** - Move window to top-right corner (quarter)
- **⌃ ⌥ ⌘ ⇧ J** - Move window to bottom-left corner (quarter)
- **⌃ ⌥ ⌘ ⇧ K** - Move window to bottom-right corner (quarter)

### Maximize & Center
- **⌃ ⌥ ⌘ ⇧ Return** - Maximize window (with 8px gap)
- **⌃ ⌥ ⌘ ⇧ C** - Center window (62% of screen size)

### Display Movement
- **⌃ ⌥ ⌘ ⇧ →** - Move window to next display
- **⌃ ⌥ ⌘ ⇧ ←** - Move window to previous display

**Note:** These bindings override the left/right halves functionality.

### Thirds Cycling (Horizontal)

These shortcuts cycle through different window sizes when pressed repeatedly within 600ms:

#### Left Side Cycling (⌃ ⌥ ⌘ ⇧ H)
1. **First press**: Left third (1/3 width)
2. **Second press** (within 600ms): Left two-thirds (2/3 width)
3. **Third press** (within 600ms): Left half (1/2 width)
4. **Fourth press** (within 600ms): Resets to left third

#### Right Side Cycling (⌃ ⌥ ⌘ ⇧ L)
1. **First press**: Right third (1/3 width)
2. **Second press** (within 600ms): Right two-thirds (2/3 width)
3. **Third press** (within 600ms): Right half (1/2 width)
4. **Fourth press** (within 600ms): Resets to right third

### Thirds Cycling (Vertical)

#### Top Cycling (⌃ ⌥ ⌘ ⇧ T) - **DISABLED** (T is now used for Safari)
1. **First press**: Top third (1/3 height)
2. **Second press** (within 600ms): Top two-thirds (2/3 height)
3. **Third press** (within 600ms): Top half (1/2 height)
4. **Fourth press** (within 600ms): Resets to top third

#### Bottom Cycling (⌃ ⌥ ⌘ ⇧ B)
1. **First press**: Bottom third (1/3 height)
2. **Second press** (within 600ms): Bottom two-thirds (2/3 height)
3. **Third press** (within 600ms): Bottom half (1/2 height)
4. **Fourth press** (within 600ms): Resets to bottom third

### Visual Grid
- **⌃ ⌥ ⌘ ⇧ G** - Show visual grid overlay (6x4 grid with 8px margins)

## App Launcher / Focus

All app shortcuts use **⌃ ⌥ ⌘ ⇧** (Hyper key) as the modifier.

- **⌃ ⌥ ⌘ ⇧ Q** - Launch/Focus WezTerm
- **⌃ ⌥ ⌘ ⇧ W** - Launch/Focus Slack
- **⌃ ⌥ ⌘ ⇧ E** - Launch/Focus IntelliJ IDEA
- **⌃ ⌥ ⌘ ⇧ R** - Launch/Focus Google Chrome
- **⌃ ⌥ ⌘ ⇧ T** - Launch/Focus Safari

**Note:** The top cycling shortcut (Hyper + T) has been disabled to make room for the Safari shortcut.

## Notes

- All window movements respect an 8px gap from screen edges
- Cycling shortcuts reset to the first state if more than 600ms passes between presses
- Window switcher shows thumbnails (160px) and titles with a semi-transparent overlay
- App shortcuts will launch the app if not running, or focus it if already running
