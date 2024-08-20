# Install NVM
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.5/install.sh | bash

# Load NVM into the current shell session
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

# Verify NVM installation
nvm --version

# Install Node.js version 16
nvm install 16

# Use Node.js version 16
nvm use 16

# Set Node.js version 16 as default
nvm alias default 16

# Verify Node.js and npm installation
node --version
npm --version

# Install Yarn globally
npm install -g yarn

# Verify Yarn installation
yarn --version

# Use Node.js version 16
nvm use 16

# Install project dependencies with Yarn
yarn

# Start the project
yarn start
