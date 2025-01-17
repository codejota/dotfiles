#!/bin/bash
#
# Installation script for macOS
#
# This script installs Homebrew, ASDF (version manager), Ruby, Node.js, and various useful applications.

set -e # Exit immediately if any command fails

# Logging functions
echo_info() { echo "[INFO] $1"; }
echo_error() { echo "[ERROR] $1"; }
echo_success() { echo "[SUCCESS] $1"; }

# Install Homebrew if not installed
install_homebrew() {
  echo_info "Checking and installing Homebrew..."
  if ! command -v brew &>/dev/null; then
    echo_info "Homebrew not found. Installing..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    # Add Homebrew to the shell's PATH if not present
    if ! grep -q 'brew shellenv' ~/.zshrc; then
      echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zshrc
    fi
    eval "$(/opt/homebrew/bin/brew shellenv)"
  else
    echo_info "Homebrew is already installed."
  fi
}

# Install ASDF if not installed
install_asdf() {
  echo_info "Installing ASDF..."
  if [ ! -d "$HOME/.asdf" ]; then
    git clone https://github.com/asdf-vm/asdf.git ~/.asdf
    echo '. "$HOME/.asdf/asdf.sh"' >> ~/.zshrc
    echo '. "$HOME/.asdf/completions/asdf.bash"' >> ~/.zshrc 
    echo 'legacy_version_file = yes' >> ~/.asdfrc
    source ~/.zshrc
  else
    echo_info "ASDF is already installed."
  fi
}

# Install Ruby and Node.js via ASDF
install_ruby_nodejs() {
  echo_info "Installing Ruby and Node.js via ASDF..."
  asdf plugin-add ruby || echo_error "Ruby plugin already exists!"
  asdf plugin-add nodejs || echo_error "Node.js plugin already exists!"
  
  asdf install ruby 3.3.3
  asdf global ruby 3.3.3
  asdf install nodejs 18.17.0
  asdf global nodejs 18.17.0
}

# Install dependencies and tools via Homebrew (using Brewfile)
install_brew_dependencies() {
  echo_info "Installing dependencies and tools using Brewfile..."

  # Create Brewfile if it doesn't exist
  BREWFILE="$HOME/Brewfile"
  
  if [ ! -f "$BREWFILE" ]; then
    echo_info "Creating Brewfile..."
    cat <<EOL > $BREWFILE
tap "homebrew/cask-fonts"
tap "homebrew/cask-versions"
tap "homebrew/command-not-found"

# Essential formulas
brew "curl"
brew "git"
brew "postgresql"
brew "zsh"
brew "gh"
brew "wget"
brew "powerlevel10k"
brew "coreutils"
brew "dockutil"
brew "autoconf"
brew "automake"
brew "brotli"
brew "c-ares"
brew "coreutils"
brew "gettext"
brew "gmp"
brew "icu4c"
brew "krb5"
brew "libevent"
brew "libidn2"
brew "libnghttp2"
brew "libssh2"
brew "libtool"
brew "libuv"
brew "libwebsockets"
brew "libyaml"
brew "lz4"
brew "m4"
brew "mosquitto"
brew "ncurses"
brew "openssl@3"
brew "pcre"
brew "pkg-config"
brew "pnpm"
brew "python@3.12"
brew "redis"
brew "sqlite"
brew "tree"
brew "unixodbc"
brew "xz"

# Applications via Cask
cask "alt-tab"
cask "arc"
cask "bitwarden"
cask "discord"
cask "displaylink"
cask "docker"
cask "dozer"
cask "font-jetbrains-mono"
cask "github"
cask "keepingyouawake"
cask "keka"
cask "maccy"
cask "obsidian"
cask "omnidisksweeper"
cask "pictogram"
cask "popsql"
cask "postman"
cask "raycast"
cask "rectangle"
cask "replacicon"
cask "soundsource"
cask "stats"
cask "steam"
cask "ticktick"
cask "visual-studio-code"
cask "warp"
cask "whatsapp"
EOL
  fi
  
  # Install dependencies from the Brewfile
  brew bundle --file=$BREWFILE || echo_error "Failed to install dependencies from Brewfile."
}

# Main script execution
install_homebrew
brew update
brew upgrade

install_asdf
install_ruby_nodejs

gem update --system
gem install rails
rails -v

install_brew_dependencies

# Update and upgrade casks
echo_info "Updating and upgrading casks..."
brew update
brew upgrade --cask

# Perform cask upgrade (brew cu)
echo_info "Upgrading all casks..."
brew tap buo/cask-upgrade
brew update
brew cu

# Finishing
echo_success "Installation and setup completed successfully."
