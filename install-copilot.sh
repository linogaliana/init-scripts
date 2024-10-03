#!/bin/bash

# Download files
# Copilot
# wget --retry-on-http-error=429 https://marketplace.visualstudio.com/_apis/public/gallery/publishers/GitHub/vsextensions/copilot/1.171.0/vspackage -O copilot.vsix.gz
# wget --retry-on-http-error=429 https://marketplace.visualstudio.com/_apis/public/gallery/publishers/GitHub/vsextensions/copilot-chat/0.13.0/vspackage -O copilot-chat.vsix.gz
mc cp s3/lgaliana/config/copilot.vsix copilot.vsix
mc cp s3/lgaliana/config/copilot-chat.vsix copilot-chat.vsix

# Install extensions
code-server --install-extension copilot.vsix
rm copilot.vsix

code-server --install-extension copilot-chat.vsix
rm copilot-chat.vsix

code-server --install-extension oderwat.indent-rainbow
code-server --install-extension pomdtr.excalidraw-editor


# Define the configuration directory for VS Code
VSCODE_CONFIG_DIR="$HOME/.local/share/code-server/User"

# Create the configuration directory if necessary
mkdir -p "$VSCODE_CONFIG_DIR"

# User settings file
SETTINGS_FILE="$VSCODE_CONFIG_DIR/settings.json"

# Enable dark mode by default
echo '{
    "workbench.colorTheme": "Default Dark Modern"
}' > "$SETTINGS_FILE"

# Keybindings file
KEYBINDINGS_FILE="$VSCODE_CONFIG_DIR/keybindings.json"

# Add shortcuts for duplicating and deleting lines
echo '[
    {
        "key": "ctrl+shift+d",
        "command": "editor.action.duplicateSelection"
    },
    {
        "key": "ctrl+d",
        "command": "editor.action.deleteLines",
        "when": "editorTextFocus"
    }
]' > "$KEYBINDINGS_FILE"

# Install nbstripout
echo "Installing nbstripout..."
pip install nbstripout

# Run nbstripout installation command in the terminal
echo "Running nbstripout --install..."
nbstripout --install

echo "Personal init done."
