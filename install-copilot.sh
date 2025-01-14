#!/bin/bash

# CONFORT EXTENSIONS ------------------------------------

code-server --install-extension oderwat.indent-rainbow
code-server --install-extension pomdtr.excalidraw-editor
code-server --install-extension tamasfe.even-better-toml
code-server --install-extension aaron-bond.better-comments
code-server --install-extension github.vscode-github-actions

# Replace default flake8 linter with project-preconfigured ruff
code-server --uninstall-extension ms-python.flake8
code-server --install-extension charliermarsh.ruff

# Install type checking extension
code-server --install-extension ms-python.mypy-type-checker


# COPILOT ------------------------------------------------

copilotVersion="1.254.1278"
copilotChatVersion="0.24.2024122001"

wget --retry-on-http-error=429 https://marketplace.visualstudio.com/_apis/public/gallery/publishers/GitHub/vsextensions/copilot/${copilotVersion}/vspackage -O copilot.vsix.gz
wget --retry-on-http-error=429 https://marketplace.visualstudio.com/_apis/public/gallery/publishers/GitHub/vsextensions/copilot-chat/${copilotChatVersion}/vspackage -O copilot-chat.vsix.gz

gzip -d copilot.vsix.gz 
gzip -d copilot-chat.vsix.gz 

code-server --install-extension copilot.vsix
code-server --install-extension copilot-chat.vsix
rm copilot.vsix copilot-chat.vsix


# VSCODE PARAMETERS -------------------------------------

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


# PYTHON NOTEBOOK CONFIGURATIONS ---------------------------

echo "Installing nbstripout..."
pip install nbstripout

# Run nbstripout installation command in the terminal
echo "Running nbstripout --install..."
nbstripout --install

echo "Personal init done."
