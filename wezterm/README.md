## WezTerm Configuration

Opinionated, modular WezTerm config with custom key mappings, modes, and pickers for fonts, sizes, and colorschemes.

### Highlights
- **Leader key**: Ctrl+Space
- **Default key bindings**: Enabled (WezTerm defaults apply)
- **Quit**: Cmd+Q quits immediately (no confirmation)
- **Config reload**: Ctrl+Shift+R
- **Command Palette**: Ctrl+Shift+P

## Getting Started

### Prerequisites
- WezTerm `>= 2024.x`

### Install
1. Ensure this repo lives at `~/.config/wezterm` (WezTerm’s default).
2. Start or restart WezTerm. To reload at runtime use: Ctrl+Shift+R.

### Platform Notes
- macOS: Cmd+Q quits application (confirmation disabled).

## Structure

```
~/.config/wezterm/
  wezterm.lua                # entrypoint
  config/                    # modular config pieces (appearance, font, window, etc.)
  mappings/                  # keymaps and modal key tables
  events/                    # event handlers (titles, command palette, status)
  picker/                    # interactive pickers and assets (fonts, sizes, colors)
  utils/                     # helpers: classes, logger, key mapping DSL, etc.
```

Entrypoint flow:
- `wezterm.lua` → loads `utils.class.config`, events, then adds `config` and `mappings` modules.
- `config/init.lua` merges `appearance`, `font`, `window`, `tab-bar`, `general`, `gpu`.
- `mappings/init.lua` merges default mappings and mode key tables.

## Key Bindings (essentials)

- Navigation: Ctrl+Tab / Ctrl+Shift+Tab → next/prev tab
- New window: Ctrl+Shift+N
- New tab: Ctrl+Shift+T
- Copy/Paste: Ctrl+Shift+C / Ctrl+Shift+V
- Fullscreen: Alt+Enter
- Clear scrollback: Ctrl+Shift+K
- Command Palette: Ctrl+Shift+P
- Reload config: Ctrl+Shift+R

Leader is `Ctrl+Space`. With Leader:
- Leader h → help mode (one-shot)
- Leader w → window mode (pane management)
- Leader f → font mode (size controls)
- Leader c → copy mode
- Leader s → search, then search mode is active
- Leader p → pick mode (colorscheme, font, size, leading)

## Modes (key tables)

- **help_mode** (one-shot): Quick access to common actions; exits after one action.
- **window_mode**: Pane focus, split, resize, swap, zoom, and close. Exit with Esc.
- **font_mode**: `+` increase, `-` decrease, `0` reset font size. Exit with Esc.
- **copy_mode**: Vim-like selection/navigation over scrollback. Exit with Esc.
- **search_mode**: Active while search UI is open; next/prev match and options.
- **pick_mode**: Interactive pickers for colorscheme/font/size/leading. Exit with Esc.

## Customization

- Colorscheme assets: `picker/assets/colorschemes/*.lua`
- Fonts: `picker/assets/fonts/*.lua`
- Font sizes: `picker/assets/font-sizes/font-sizes.lua`
- Line height (leading): `picker/assets/font-leadings/font-leadings.lua`

Update window behavior in `config/window.lua` (e.g., tab bar options, `window_close_confirmation`).

## Behavior Tweaks Included

- `window_close_confirmation = "NeverPrompt"` (quit without confirmation)
- Default key bindings are enabled (no need to rebind common platform shortcuts).

## Troubleshooting

- Changes not applying: Use Ctrl+Shift+R to reload config, or restart WezTerm.
- Key not working: Check `mappings/default.lua` and `mappings/modes.lua` for collisions.
- Colorscheme not listed: Ensure the file exists under `picker/assets/colorschemes` and returns a table named `scheme`.

## License

Most modules note GNU GPLv3 headers; follow those notices for reuse.


