# Hammerspoon Configuration

Opinionated Hyper-key workflow for macOS built with Hammerspoon. Includes a custom `⌥ Tab` switcher, window management shortcuts, a visual grid overlay, and a quick app launcher.

## File Layout

| File | Description |
| --- | --- |
| `init.lua` | Entry point that loads every module |
| `config.lua` | Shared settings (Hyper key = `⌃⌥⌘⇧`, 8 px gap, helper fns) |
| `app-switcher.lua` + `Custom/AppSwitcher/app.lua` | Canvas-based AltTab replacement |
| `window-basic.lua` | Halves / maximize / center |
| `window-display.lua` | Move windows between monitors |
| `window-grid.lua` | Show `hs.grid` overlay |
| `app-launcher.lua` | Hyper-key launcher for favorite apps |

Reload the config via the Hammerspoon menu-bar icon after edits.

## Custom App Switcher (`⌥ Tab`)

- Dedicated hotkey: `⌥ Tab` (no need to touch macOS `⌘ Tab`)
- Dimmed background + centered strip of app cards showing icon + letter
- Tap the highlighted letter to focus that app (letters auto-assigned)
- `Esc` dismisses the switcher
- Uses `hs.application.watcher` to stay in sync as apps launch/quit
- **No Hyper key bindings** are created—only on-screen single-letter keys

## Window Management (`window-basic.lua`)

All shortcuts use the Hyper chord (`⌃⌥⌘⇧`). Windows respect an 8 px inset from screen edges.

| Hotkey | Action |
| --- | --- |
| Hyper + **H** | Left half |
| Hyper + **L** | Right half |
| Hyper + **J** | Maximize (usable frame) |
| Hyper + **K** | Center (~62% width) |

## Displays (`window-display.lua`)

| Hotkey | Action |
| --- | --- |
| Hyper + **,** (physical **<**) | Move window to the next display |
| Hyper + **.** (physical **>**) | Move window to the previous display |

No animation; window size/position are preserved per monitor.

## Visual Grid (`window-grid.lua`)

| Hotkey | Action |
| --- | --- |
| Hyper + **M** | Toggle `hs.grid` (6×4 grid, 8 px margins) |

Great for precise tiling when halves/center aren’t enough.

## App Launcher (`app-launcher.lua`)

Manual bindings for daily drivers:

| Hotkey | App |
| --- | --- |
| Hyper + **A** | Visual Studio Code |
| Hyper + **S** | Slack |
| Hyper + **D** | Google Chrome |
| Hyper + **F** | WezTerm |
| Hyper + **G** | Safari |
| Hyper + **V** | IntelliJ IDEA |

These use `hs.application.launchOrFocus`, so they open the app if needed or focus it if already running. Feel free to change the letters/apps in `app-launcher.lua`.

## Behavior Notes

- Hyper key lives in `config.lua` (`{ "ctrl","alt","cmd","shift" }`)
- `GAP` determines padding from screen edges (default 8 px)
- App switcher auto-hides after 3 seconds if no selection is made
- `hs.hotkey.getHotkeys()` should only list the bindings in this README; if you see others, another tool (e.g., Karabiner) is also mapping keys
- Requires Hammerspoon with Accessibility permissions

## Customize / Troubleshoot

- Change launcher targets or keys in `app-launcher.lua`
- Style the switcher in `Custom/AppSwitcher/app.lua`
- Resize the grid in `window-grid.lua`
- If `⌥ Tab` stops working, reload the config and check the console (`⌘4`) for errors

Enjoy the setup—and tweak to match your workflow! 🚀
