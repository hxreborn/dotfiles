# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What This Is

OmniWM configuration directory (`~/.config/omniwm/`). OmniWM is a macOS tiling window manager. The entire config is a single `settings.json` file — there is no build system, no tests, no code to compile.

## Configuration Structure

`settings.json` is a flat JSON object with these major sections:

- **appRules**: per-app minimum window dimensions, keyed by macOS `bundleId` (each entry has a UUID `id`)
- **hotkeyBindings**: keyboard shortcuts mapped to action IDs (e.g. `switchWorkspace.0`, `focus.left`, `move.right`). Use `"Unassigned"` to explicitly unbind
- **workspaceConfigurations**: named workspaces with layout type and monitor assignment
- **Dwindle layout settings**: prefix `dwindle*` — split ratios, smart split, aspect ratio
- **Niri layout settings**: prefix `niri*` — column width presets, max visible columns, centering behavior
- **Gaps and borders**: `gapSize`, `outerGap{Top,Bottom,Left,Right}`, `borderWidth`, `borderColor{Red,Green,Blue,Alpha}`
- **Workspace bar**: prefix `workspaceBar*` — position, height, font size, colors, visibility toggles
- **Quake terminal**: prefix `quakeTerminal*` — drop-down terminal config (size, position, opacity, animation)
- **Mouse/gesture**: `focusFollowsMouse`, `scrollGesture*`, `mouseWarp*`, `gestureFingerCount`
- **Monitor-specific overrides**: `monitorBarSettings`, `monitorDwindleSettings`, `monitorNiriSettings`, `monitorOrientationSettings` (currently empty arrays)

## Key Conventions

- Hotkey modifier names: `Option`, `Shift`, `Control`, `Command`, combined with `+` (e.g. `Option+Shift+Left Arrow`)
- Action IDs use dot notation with zero-based indices: `switchWorkspace.0`, `focusColumn.3`, `move.left`
- App bundle IDs follow reverse-domain format: `com.google.Chrome`, `com.mitchellh.ghostty`
- Color values are RGBA floats (0.0–1.0); accent colors use `-1` to mean "use system default"
- All UUIDs are uppercase with hyphens

## Current Layout

- Default layout: `dwindle`
- 5 workspaces (named "1"–"5"), all assigned to main monitor
- Hotkeys: `Option+N` switches to workspace N, `Option+Shift+N` moves window to workspace N
- Focus: `Option+Arrow`, Move: `Option+Shift+Arrow`, Resize: `Command+Option+Arrow`
- Quake terminal on `Option+backtick` (Ghostty, 50% width/height, centered)

## Editing Notes

- Preserve existing UUIDs when modifying entries — OmniWM uses them for internal state tracking
- The `version` field (currently `4`) should not be changed manually
- Settings take effect after OmniWM reloads; no restart command is needed from CLI
