#!/bin/bash

# Download files
# Copilot
while [ 1 ]; do
    wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 --continue https://marketplace.visualstudio.com/_apis/public/gallery/publishers/GitHub/vsextensions/copilot/1.133.0/vspackage -O copilot.vsix.gz
    if [ $? = 0 ]; then break; fi; # check return value, break if successful (0)
    sleep 2s;
done;
# Copilot-chat
while [ 1 ]; do
    wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 --continue https://marketplace.visualstudio.com/_apis/public/gallery/publishers/GitHub/vsextensions/copilot-chat/0.7.1/vspackage -O copilot-chat.vsix.gz
    if [ $? = 0 ]; then break; fi; # check return value, break if successful (0)
    sleep 2s;
done;

# Install extensions
gunzip copilot.vsix.gz 
code-server --install-extension copilot.vsix
rm copilot.vsix

gunzip copilot-chat.vsix.gz 
code-server --install-extension copilot-chat.vsix
rm copilot-chat.vsix
