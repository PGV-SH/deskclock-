# DeskClock · 极简时钟

[中文 README](README.md)

Turn a spare tablet, old phone, or old computer into an elegant desk clock. A single-file web core powers **Windows / macOS / Android / iOS / browser** with the same interface.

![Platform](https://img.shields.io/badge/platform-Windows%20%7C%20macOS%20%7C%20Android%20%7C%20iOS%20%7C%20Web-blue)
![License](https://img.shields.io/badge/license-CC%20BY--NC%204.0-orange)

## Features

### 13 Clock Faces
Roman · Minimal · Square · Digital · Flip Cards · World · Word Clock · Rings · Stacked · Binary · Dot Matrix · Split · Big Date

### Personalization
- **Alarms**: dedicated alarm panel (bell icon in the toolbar, shortcut `A`), multiple alarms with snooze, 4 sounds synthesized in code via Web Audio including an intense siren (no audio files, zero copyright concerns)
- **Multi-language**: follows your system language by default — 简体中文, 繁體中文, English, 日本語, Français, Deutsch, Español, 한국어 — with manual override in Settings
- **Custom background image**: pick any photo as the clock background; compressed and stored locally, never uploaded
- **World clock**: choose up to 6 cities from 22, shown side by side
- **4 themes**: Dark / Paper / Ink / Warm, plus 6 accent colors
- **Display details**: 24-hour format, seconds, date, and smooth second hand are all toggleable

### Designed for Always-on Display
- **Burn-in protection**: the canvas drifts slowly and periodically to protect OLED screens
- **Keep screen on**: prevents the device from sleeping (system-level power management on desktop)
- **Auto dim at night**: brightness drops automatically from 22:00 to 7:00
- **Auto-hide UI**: all buttons fade away after a few idle seconds, leaving a pure clock
- Click anywhere outside the settings panel to close it and return to the clock

## Download

Get the package for your platform from the [Releases](../../releases) page:

| Platform | File | Notes |
| --- | --- | --- |
| Windows | `DeskClock-Setup-1.2.0.exe` | Installer (creates a desktop shortcut) |
| Windows | `DeskClock-Windows.zip` | Portable, unzip and run |
| macOS (Apple Silicon) | `DeskClock-1.2.0-arm64.dmg` | M1/M2/M3/M4 |
| macOS (Intel) | `DeskClock-1.2.0-x64.dmg` | Intel processors |
| Android | `DeskClock-1.2.0.apk` | Android 8.0+ |
| iOS | `DeskClock-1.2.0-unsigned.ipa` | iOS 15+, self-signing required |

## Usage

- **Desktop (Windows / macOS)**: launches in fullscreen (kiosk) mode; press `Esc` to exit, or `Cmd+Ctrl+F` on macOS
- **Android**: double-tap Back to quit
- **Keyboard shortcuts**:

| Key | Action |
| --- | --- |
| `1` – `9` | Quick face switching |
| `←` `→` | Previous / next face |
| `F` / double-click | Toggle fullscreen |
| `S` | Open / close settings |
| `T` | Cycle themes |
| `Space` | Hide UI immediately |

## Technical Notes

- The core is a single-file HTML/CSS/JS app: no third-party JS libraries, no network requests, **zero data collection**
- Desktop builds are packaged with [Electron](https://www.electronjs.org/); Android and iOS are native WebView shells
- All icons, faces, and UI are hand-drawn SVG/CSS

## License

**© 2026 Zohan**

This project is open-sourced under **[CC BY-NC 4.0 (Attribution-NonCommercial)](https://creativecommons.org/licenses/by-nc/4.0/)** — see [LICENSE](LICENSE):

- ✅ Free to use, copy, modify, and build upon
- ✅ Derivative works and redistribution **must credit the original author Zohan** and link back to this repository
- ❌ **No commercial use**: you may not sell this project or its derivatives, bundle it in paid apps, or distribute it for profit in any form
- Background images chosen by users remain the responsibility of the users themselves

### Third-party Acknowledgements

| Component | License | Used for |
| --- | --- | --- |
| [Electron](https://www.electronjs.org/) | MIT | Windows / macOS desktop runtime |
| [Chromium](https://www.chromium.org/) | BSD | Rendering engine inside Electron |

Full license texts of the above components are bundled with the packages (`LICENSE`, `LICENSES.chromium.html`).
<img width="2560" height="1351" alt="e0f79a6ca12d65bb8c321fc8c8d3c67f" src="https://github.com/user-attachments/assets/bfba8e8f-157b-416b-8f13-17d40bcca7b3" />
<img width="1853" height="1290" alt="截屏2026-10-31 16 00 12" src="https://github.com/user-attachments/assets/5141d381-0d25-46d3-b77a-5bb05808b7c4" />
<img width="2560" height="1350" alt="80e0c3cf641d6223d452512781314ca6" src="https://github.com/user-attachments/assets/a0706195-0a6f-4724-8e5e-be7fd9a2b9f1" />
<img width="2560" height="1350" alt="9f28df44c9253eb511189ba6bfcc8b14" src="https://github.com/user-attachments/assets/6a03f16f-6b59-4d96-95ed-4f27d40d6365" />
