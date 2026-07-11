#!/usr/bin/env bash
#
# install.sh -- installs Cinnasole as a real command and app launcher entry.
#
# What this does, concretely:
#   1. Copies cinnasole.py to ~/.local/bin/cinnasole (executable, no .py
#      extension) so typing 'cinnasole' from anywhere runs it.
#   2. Installs a .desktop file so Cinnasole shows up in your app launcher
#      (KDE menu, etc.) and opens straight into the cinnasole> prompt
#      when clicked -- distinct from typing 'cinnasole' in an existing
#      terminal, which still opens the website as designed.
#
# Run it with:
#   bash install.sh
#
# This only touches your user's own directories (~/.local/bin,
# ~/.local/share/applications) -- no sudo, no system-wide changes.

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SOURCE_FILE="$SCRIPT_DIR/cinnasole.py"

BIN_DIR="$HOME/.local/bin"
BIN_TARGET="$BIN_DIR/cinnasole"

APPS_DIR="$HOME/.local/share/applications"
DESKTOP_FILE="$APPS_DIR/cinnasole.desktop"

ICON_DIR="$HOME/.local/share/icons"
ICON_TARGET="$ICON_DIR/cinnasole.png"

echo "=== Cinnasole installer ==="
echo

# --- Sanity check: the actual script needs to exist next to this installer ---
if [[ ! -f "$SOURCE_FILE" ]]; then
    echo "Error: cinnasole.py not found at $SOURCE_FILE"
    echo "Make sure install.sh sits in the same folder as cinnasole.py."
    exit 1
fi

# --- Step 1: install the command itself ---
mkdir -p "$BIN_DIR"
cp "$SOURCE_FILE" "$BIN_TARGET"
chmod +x "$BIN_TARGET"
echo "Installed command: $BIN_TARGET"

# --- Check whether ~/.local/bin is actually on PATH ---
# This matters a lot: if it isn't, 'cinnasole' will fail with
# "command not found" right after this script claims success, which is
# a confusing way to discover a missing PATH entry. Checking and warning
# now is much clearer than letting that happen silently.
if [[ ":$PATH:" != *":$BIN_DIR:"* ]]; then
    echo
    echo "WARNING: $BIN_DIR is not on your PATH."
    echo "Add this line to your ~/.bashrc or ~/.zshrc, then restart your terminal:"
    echo
    echo "    export PATH=\"\$HOME/.local/bin:\$PATH\""
    echo
fi

# --- Step 2: find nano or a fallback for --edit's own dependency check ---
# (Not installed here -- just informational, since --edit already offers
# to install nano itself if it's missing when actually invoked.)

# --- Step 3: install a simple icon ---
# A plain generated icon rather than requiring the user supply one --
# keeps the installer self-contained. Uses the frame1.png from the
# website's /images folder if it's present nearby, otherwise skips the
# icon (the .desktop file still works without one, just shows a generic
# terminal icon instead).
mkdir -p "$ICON_DIR"
POSSIBLE_ICON_SOURCES=(
    "$SCRIPT_DIR/images/frame1.png"
    "$SCRIPT_DIR/../images/frame1.png"
    "$SCRIPT_DIR/frame1.png"
)
ICON_INSTALLED=false
for candidate in "${POSSIBLE_ICON_SOURCES[@]}"; do
    if [[ -f "$candidate" ]]; then
        cp "$candidate" "$ICON_TARGET"
        ICON_INSTALLED=true
        echo "Installed icon: $ICON_TARGET (from $candidate)"
        break
    fi
done

if [[ "$ICON_INSTALLED" == false ]]; then
    echo "No frame1.png found nearby -- skipping custom icon."
    echo "(The launcher entry will still work, just with a generic icon.)"
fi

# --- Step 4: figure out which terminal emulator to launch ---
# The .desktop file needs to open an actual terminal window running
# 'cinnasole --start' -- it can't just run cinnasole directly, because
# a .desktop Exec line runs headless with no visible terminal attached
# unless one is explicitly launched. This checks for Kitty first (named
# in the original project scope), then Konsole, then a couple of common
# fallbacks, and uses whichever is actually found.
TERMINAL_CMD=""
if command -v kitty &>/dev/null; then
    TERMINAL_CMD="kitty --hold -e cinnasole --start"
elif command -v konsole &>/dev/null; then
    TERMINAL_CMD="konsole --hold -e cinnasole --start"
elif command -v xterm &>/dev/null; then
    TERMINAL_CMD="xterm -hold -e cinnasole --start"
else
    echo
    echo "WARNING: no terminal emulator (kitty, konsole, xterm) was found."
    echo "The app launcher entry will be installed, but you'll need to edit"
    echo "$DESKTOP_FILE afterward to point Exec= at your actual terminal."
    TERMINAL_CMD="kitty --hold -e cinnasole --start"  # best-effort default
fi

# --- Step 5: write the .desktop file ---
mkdir -p "$APPS_DIR"
cat > "$DESKTOP_FILE" << EOF
[Desktop Entry]
Type=Application
Name=Cinnasole
Comment=Command launcher for your Linux terminal
Exec=$TERMINAL_CMD
Icon=$([ "$ICON_INSTALLED" == true ] && echo "$ICON_TARGET" || echo "utilities-terminal")
Terminal=false
Categories=Utility;System;
EOF

chmod +x "$DESKTOP_FILE"
echo "Installed launcher entry: $DESKTOP_FILE"

echo
echo "=== Done ==="
echo "Command line:  cinnasole            (opens the website, as before)"
echo "               cinnasole --start    (opens the prompt directly)"
echo "App launcher:  Cinnasole            (opens straight into the prompt)"
