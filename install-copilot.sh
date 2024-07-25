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
