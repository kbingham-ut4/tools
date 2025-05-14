#!/bin/bash

# Update the system
echo "Updating system..."
sudo apt update && sudo apt upgrade -y

# Install necessary system dependencies
echo "Installing necessary dependencies..."
sudo apt install -y curl wget git build-essential software-properties-common

# Install Zsh
echo "Installing Zsh..."
sudo apt install -y zsh

# Set Zsh as the default shell
echo "Setting Zsh as default shell..."
chsh -s $(which zsh)

# Install Homebrew
echo "Installing Homebrew..."
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Add Homebrew to the shell environment
echo "Adding Homebrew to the shell environment..."
echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >>~/.zprofile
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

# Install Git
echo "Installing Git..."
brew install git

# Verify Git installation
echo "Verifying Git installation..."
git --version

# Install Docker
echo "Installing Docker..."
brew install --cask docker

# Verify Docker installation
echo "Verifying Docker installation..."
docker --version

# Install Tilt
echo "Installing Tilt..."
brew install tilt

# Verify Tilt installation
echo "Verifying Tilt installation..."
tilt version

# Install Powerlevel10k
#echo "Installing Powerlevel10k..."
#brew install romkatv/powerlevel10k/powerlevel10k

# Install Oh My Zsh
echo "Installing Oh My Zsh..."
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Set Powerlevel10k as the theme
#echo "Setting Powerlevel10k as the theme..."
#sed -i 's/^ZSH_THEME=.*/ZSH_THEME="powerlevel10k\/powerlevel10k"/' ~/.zshrc

# Install NVM (Node Version Manager)
echo "Installing NVM..."
brew install nvm
export NVM_DIR="$HOME/.nvm"
mkdir -p "$NVM_DIR"
echo 'export NVM_DIR="$HOME/.nvm"' >> ~/.zshrc
echo '[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"' >> ~/.zshrc
source ~/.zshrc

# Install Node.js 22 using NVM
echo "Installing Node.js 22 using NVM..."
nvm install 22
nvm use 22
nvm alias default 22

# Install PNPM
echo "Installing PNPM..."
brew install pnpm

# Add PNPM to the shell environment
echo "Adding PNPM to the shell environment..."
export PNPM_HOME="$HOME/.local/share/pnpm"
export PATH="$PNPM_HOME:$PATH"
echo 'export PNPM_HOME="$HOME/.local/share/pnpm"' >> ~/.zshrc
echo 'export PATH="$PNPM_HOME:$PATH"' >> ~/.zshrc

# Install PHP 8.4
echo "Installing PHP 8.4..."
brew tap shivammathur/php
brew install php@8.4

# Verify PHP installation
echo "Verifying PHP installation..."
php -v

# Install Composer
echo "Installing Composer..."
brew install composer

# Verify Composer installation
echo "Verifying Composer installation..."
composer --version

# Install GitHub CLI
echo "Installing GitHub CLI..."
brew install gh

# Verify GitHub CLI installation
echo "Verifying GitHub CLI installation..."
gh --version

# Install Laravel globally
echo "Installing Laravel globally..."
composer global require laravel/installer

# Add Composer global bin to PATH
echo "Adding Composer global bin to PATH..."
export PATH="$HOME/.composer/vendor/bin:$PATH"
echo 'export PATH="$HOME/.composer/vendor/bin:$PATH"' >> ~/.zshrc

# Install Vue.js globally
echo "Installing Vue.js globally..."
npm install -g @vue/cli

# Verify Laravel and Vue.js installations
echo "Verifying Laravel installation..."
laravel --version
echo "Verifying Vue.js installation..."
vue --version

# Move bash aliases to .zshrc
echo "Moving bash aliases to .zshrc..."
cat <<EOL >> ~/.zshrc

# Git aliases
alias gs='git status'
alias ga='git add .'
alias gc='git commit -m'
alias gp='git push'
alias gl='git pull'
alias gd='git diff'

# Docker aliases
alias dcu='docker-compose up'
alias dcd='docker-compose down'
alias dcb='docker-compose build'
alias dcl='docker-compose logs'

# NPM/Yarn aliases
alias ni='npm install'
alias nr='npm run'
alias yi='yarn install'
alias yr='yarn run'

# Laravel aliases
alias art='php artisan'
alias tinker='php artisan tinker'
alias migrate='php artisan migrate'
alias seed='php artisan db:seed'

# General development aliases
alias serve='php -S localhost:8000'
alias code='code .' # Open VS Code in the current directory

# System aliases
alias update='sudo apt update && sudo apt upgrade -y'
alias cls='clear'
alias ll='ls -la'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias ~='cd ~'
alias g='git'
alias h='history'
alias c='clear'
alias p='ping'
alias df='df -h'
alias du='du -h'
alias free='free -h'
alias top='htop'
alias grep='grep --color=auto'
alias ls='ls --color=auto'
alais src='source ~/.zshrc'


EOL

# Remove ~/.bash_aliases if it exists
echo "Removing ~/.bash_aliases if it exists..."
rm -f ~/.bash_aliases

# Source the updated .zshrc
echo "Sourcing the updated .zshrc..."
source ~/.zshrc

# Finalize setup
echo "Installation complete! Please restart your terminal or run 'source ~/.zshrc' to apply the changes."
