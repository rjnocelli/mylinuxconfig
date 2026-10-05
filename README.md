# mylinuxconfig

My GNOME desktop setup: extensions, extension settings, workspaces, and keyboard shortcuts.

Captured on **Ubuntu 24.04 LTS, GNOME Shell 46, Wayland**. Other GNOME versions may need
different extension versions, and some settings may not apply.

## What's in here

| Path | Contents |
| --- | --- |
| `dconf/extensions.txt` | Settings for every extension (`/org/gnome/shell/extensions/`) |
| `dconf/enabled-extensions.txt` | Which extensions are turned on |
| `dconf/disabled-extensions.txt` | Which extensions are explicitly turned off |
| `dconf/wm-keybindings.txt` | Workspace / monitor shortcuts (`/org/gnome/desktop/wm/keybindings/`) |
| `dconf/wm-preferences.txt` | 4 fixed workspaces, window buttons (`/org/gnome/desktop/wm/preferences/`) |
| `dconf/mutter.txt` | Static workspaces, edge tiling off (`/org/gnome/mutter/`) |
| `dconf/media-keys.txt` | Custom shortcut: Ctrl+Alt+T opens the terminal |
| `dconf-dump.sh` / `dconf-load.sh` | Save / restore all of the above |
| `shortcuts.txt` | Cheat sheet of the shortcuts I use |
| `bin/` | Personal scripts (see `bin/README.md`) |

## Setting up a new machine

### 1. Install the extensions

The dconf files only hold *settings*. The extensions themselves must be installed first,
otherwise their settings do nothing.

```bash
sudo apt install gnome-shell-extension-manager gnome-shell-extensions
```

Then open **Extension Manager** and install these from extensions.gnome.org:

| Extension | UUID |
| --- | --- |
| Vitals | `Vitals@CoreCoding.com` |
| Auto Move Windows | `auto-move-windows@gnome-shell-extensions.gcampax.github.com` |
| Space Bar | `space-bar@luchrioh` |
| Switcher | `switcher@landau.fi` |
| Just Perfection | `just-perfection-desktop@just-perfection` |

These come preinstalled with Ubuntu: Desktop Icons NG (`ding@rastersoft.com`),
Tiling Assistant (`tiling-assistant@ubuntu.com`), Ubuntu Dock (`ubuntu-dock@ubuntu.com`, kept disabled).

Tactile (`tactile@lundal.io`) has saved settings but is disabled, so it's optional.

### 2. Load the settings

```bash
git clone <this repo> ~/dev/mylinuxconfig
cd ~/dev/mylinuxconfig
./dconf-load.sh
```

Then **log out and back in**. On Wayland, GNOME Shell only picks up new extensions after a
re-login.

### 3. Install the scripts in `bin/`

```bash
mkdir -p ~/.local/bin
cp bin/note bin/notes ~/.local/bin/
```

### 4. Check what isn't covered

These are **not** saved here and have to be set up by hand:

- The apps themselves (Firefox, VS Code, Slack, ...). `auto-move-windows` sends Firefox to
  workspace 1, VS Code to 2 and the terminal to 3, so the `.desktop` names must match
  (for example, Firefox installed as a snap is `firefox_firefox.desktop`).
- Dock favorites, theme, wallpaper, fonts, and other GNOME settings outside the paths above.

## Known gotchas

- **Shift+Super+Number (move window to workspace) resetting to default.** Space Bar resets
  `move-to-workspace-1..10` to GNOME's defaults whenever its own *"Move to workspace"* shortcut
  option is off and it gets a change notification. Those notifications can fire without a real
  change, e.g. after a bulk dconf write or a JumpCloud policy refresh. Fix: keep that option
  **on** (`[space-bar/shortcuts] enable-move-to-workspace-shortcuts=true`, already in
  `dconf/extensions.txt`) so Space Bar sets `<Super><Shift>N` itself. Change the binding in
  Space Bar's settings, not in GNOME Settings.

## Updating this repo after changing settings

```bash
./dconf-dump.sh
git diff   # review
```

The `launcher-stats` line under `[switcher]` in `dconf/extensions.txt` counts how often each
app is launched, so it changes in every dump even if no setting changed. That diff is harmless.
