#!/bin/bash

# CONFORT EXTENSIONS ------------------------------------

code-server --install-extension yzhang.markdown-all-in-one
code-server --install-extension oderwat.indent-rainbow
code-server --install-extension pomdtr.excalidraw-editor
code-server --install-extension tamasfe.even-better-toml
code-server --install-extension aaron-bond.better-comments
code-server --install-extension adpyke.codesnap
code-server --install-extension github.vscode-github-actions


# Replace default flake8 linter with project-preconfigured ruff
code-server --uninstall-extension ms-python.flake8
code-server --install-extension charliermarsh.ruff

# Continue extension
# code-server --install-extension continue.continue

# COPILOT ------------------------------------------------

copilotVersion="1.270.0"
copilotChatVersion="0.23.0"

wget --retry-on-http-error=429 https://marketplace.visualstudio.com/_apis/public/gallery/publishers/GitHub/vsextensions/copilot/${copilotVersion}/vspackage -O copilot.vsix.gz
wget --retry-on-http-error=429 https://marketplace.visualstudio.com/_apis/public/gallery/publishers/GitHub/vsextensions/copilot-chat/${copilotChatVersion}/vspackage -O copilot-chat.vsix.gz

gzip -d copilot.vsix.gz 
gzip -d copilot-chat.vsix.gz 

code-server --install-extension copilot.vsix
code-server --install-extension copilot-chat.vsix
rm copilot.vsix copilot-chat.vsix


# STARSHIP COMMAND LINE ------------------------------------------

curl -sS https://starship.rs/install.sh | sudo sh -s -- -y
echo eval "$(starship init bash)" >> ~/.bashrc


mkdir -p ~/.config

echo "
[aws]
disabled = true

[container]
disabled = true
" >> ~/.config/starship.toml


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
    "workbench.editor.wrapTabs": true
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
        "key": "ctrl+shift+c",
        "command": "editor.action.commentLine"
    },
    {
        "key": "ctrl+d",
        "command": "editor.action.deleteLines",
        "when": "editorTextFocus"
    },
    {
        "key": "ctrl+alt+left",
        "command": "workbench.action.previousEditor"
    },
    {
        "key": "ctrl+alt+right",
        "command": "workbench.action.nextEditor"
    },
    {
        "key": "ctrl+w",
        "command": "workbench.action.closeActiveEditor"
    },
    {
        "key": "ctrl+l",
        "command": "expandLineSelection",
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

# VSCODE PERSONAL SETTINGS -----------------------

jq '. + {
    "workbench.colorTheme": "Default Dark Modern",  # Set the theme
    "workbench.editor.wrapTabs": true,

    "editor.rulers": [80, 100, 120],  # Add specific vertical rulers
    "files.trimTrailingWhitespace": true,  # Automatically trim trailing whitespace
    "files.insertFinalNewline": true,  # Ensure files end with a newline

    "flake8.args": [
        "--max-line-length=100"  # Max line length for Python linting
    ]


    
}' "$SETTINGS_FILE" > "$SETTINGS_FILE.tmp" && mv "$SETTINGS_FILE.tmp" "$SETTINGS_FILE"

