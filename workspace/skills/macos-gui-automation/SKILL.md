---
name: macos
description: Automate macOS GUI interactions using Peekaboo. Use when the user asks to control macOS applications, click buttons, type text, manage windows, or perform any native macOS UI operations.
allowed-tools: Bash
---

# macOS GUI Automation

Automate native macOS applications using Peekaboo CLI.

## First: Check Peekaboo Daemon

Make sure Peekaboo daemon is running:

```bash
peekaboo daemon status
```

If not running, start it:

```bash
peekaboo daemon start
```

## Setup (First Time Only)

### 1. Grant Permissions

Peekaboo requires these permissions in System Settings:

1. **Screen Recording** (System Settings → Privacy & Security → Screen Recording)
2. **Accessibility** (System Settings → Privacy & Security → Accessibility)

Without Accessibility permission, Peekaboo cannot control UI elements.

### 2. Install Peekaboo (if not installed)

```bash
brew install peekaboo
```

## Commands

### Application Control

```bash
# Open an application
peekaboo app launch "Safari"

# Quit an application
peekaboo app quit "Safari"

# Switch to an application
peekaboo app switch "Safari"

# List running apps
peekaboo list apps
```

### Window Control

```bash
# List windows
peekaboo list windows

# Close front window
peekaboo window close

# Minimize window
peekaboo window minimize

# Maximize window
peekaboo window maximize
```

### Mouse & Keyboard

```bash
# Click at position
peekaboo click 100 200

# Click on element (by description)
peekaboo click "Submit button"

# Type text
peekaboo type "Hello World"

# Press key
peekaboo press enter
peekaboo press cmd c
peekaboo press cmd v

# Keyboard shortcut
peekaboo hotkey cmd n
peekaboo hotkey cmd tab
```

### Vision (AI-Powered UI Understanding)

```bash
# See what's on screen
peekaboo see

# Click based on visual description
peekaboo click "the red button in the top right"

# Find and interact with UI elements
peekaboo see "Find the login button and click it"
```

### Agent (AI Automation)

```bash
# Let AI control the UI
peekaboo agent "Open Safari and go to github.com"
```

## Quick Example

```bash
# Open Finder and create a new folder
peekaboo app launch "Finder"
peekaboo hotkey cmd shift n
peekaboo type "My New Folder"
peekaboo press enter
```

## Best Practices

1. **Check permissions first** - Accessibility is required
2. **Use `peekaboo list apps`** to see running applications
3. **Use `peekaboo see`** to understand current screen state
4. **Use agent mode** for complex multi-step tasks

## Troubleshooting

- **Accessibility missing**: Grant in System Settings → Privacy & Security → Accessibility
- **Element not found**: Use `peekaboo see` to inspect the screen
- **Action fails**: Try using agent mode for complex tasks

## Combined with Browser Automation

Use this skill together with `browser` skill for:
- Browser automation (Stagehand/Playwright)
- Native macOS automation (Peekaboo)

Example workflow:
1. Use browser skill to navigate to a website
2. Use macos skill to save the page as PDF via macOS menu
