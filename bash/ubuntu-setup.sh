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

# Install Powerlevel10k
echo "Installing Powerlevel10k..."
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $HOME/.oh-my-zsh/custom/themes/powerlevel10k

# Install Oh My Zsh
echo "Installing Oh My Zsh..."
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Set Powerlevel10k as the theme
echo "Setting Powerlevel10k as the theme..."
sed -i 's/^ZSH_THEME=.*/ZSH_THEME="powerlevel10k\/powerlevel10k"/' ~/.zshrc

# Install NVM (Node Version Manager)
echo "Installing NVM..."
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

# Install Node.js 22 using NVM
echo "Installing Node.js 22 using NVM..."
nvm install 22
nvm use 22
nvm alias default 22

# Install PNPM
echo "Installing PNPM..."
curl -fsSL https://get.pnpm.io/install.sh | bash -

# Add PNPM to the shell environment
echo "Adding PNPM to the shell environment..."
export PNPM_HOME="$HOME/.local/share/pnpm"
export PATH="$PNPM_HOME:$PATH"
echo 'export PNPM_HOME="$HOME/.local/share/pnpm"' >> ~/.zshrc
echo 'export PATH="$PNPM_HOME:$PATH"' >> ~/.zshrc

# Install PHP 8.4
echo "Installing PHP 8.4..."
sudo add-apt-repository -y ppa:ondrej/php
sudo apt update
sudo apt install -y php8.4 php8.4-cli php8.4-fpm php8.4-mysql php8.4-xml php8.4-curl php8.4-mbstring php8.4-zip php8.4-soap

# Verify PHP installation
echo "Verifying PHP installation..."
php -v

# Install Composer
echo "Installing Composer..."
curl -sS https://getcomposer.org/installer | php
sudo mv composer.phar /usr/local/bin/composer
echo 'export PATH="$PATH:/usr/local/bin"' >> ~/.zshrc

# Verify Composer installation
echo "Verifying Composer installation..."
composer --version

# Finalize setup
echo "Installation complete! Please restart your terminal or run 'source ~/.zshrc' to apply the changes."