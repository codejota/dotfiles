#!/bin/bash
#
# Installation script for macOS (Universal Version)
#

set -e # Exit immediately if any command fails

# Carrega utils para ter acesso às funções de log e detecção
source ./scripts/utils.sh

# Install Homebrew if not installed
install_homebrew() {
  echo_info "Checking and installing Homebrew..."
  
  if ! command -v brew &>/dev/null; then
    echo_info "Homebrew not found. Installing..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    
    # Configura PATH temporário baseado no utils.sh
    eval "$($HOMEBREW_PREFIX/bin/brew shellenv)"
  else
    echo_info "Homebrew is already installed."
    eval "$($HOMEBREW_PREFIX/bin/brew shellenv)"
  fi
}

# Install dependencies via Homebrew Bundle
install_brew_dependencies() {
  echo_info "Installing dependencies, apps and vscode extensions..."

  BREWFILE="$HOME/Brewfile"
   
  # Sempre recria o arquivo para garantir lista atualizada
  echo_info "Updating Brewfile list..."
  cat <<EOL > $BREWFILE
tap "homebrew/command-not-found"

# --- Brews ---
brew "brotli"
brew "lz4"
brew "xz"
brew "asdf"
brew "m4"
brew "autoconf"
brew "automake"
brew "blueutil"
brew "c-ares"
brew "gettext"
brew "gmp"
brew "coreutils"
brew "libnghttp2"
brew "openssl@3"
brew "libssh2"
brew "curl"
brew "dockutil"
brew "libevent"
brew "libidn2"
brew "icu4c@77"
brew "ffmpeg"
brew "gh"
brew "git"
brew "go"
brew "krb5"
brew "libusb"
brew "libmtp"
brew "libtool"
brew "libuv"
brew "libwebsockets"
brew "libyaml"
brew "mosquitto"
brew "ncurses"
brew "ncdu"
brew "nmap"
brew "nut"
brew "pcre"
brew "pkgconf"
brew "pnpm"
brew "postgresql@14"
brew "powerlevel10k"
brew "pyenv"
brew "pyenv-virtualenv"
brew "python@3.12"
brew "python@3.9"
brew "redis"
brew "stress"
brew "tree"
brew "unixodbc"
brew "wget"
brew "zsh"

# --- Casks ---
cask "alt-tab"
cask "arc"
cask "bitwarden"
cask "discord"
cask "displaylink"
cask "docker-desktop"
cask "font-jetbrains-mono"
cask "github"
cask "keepingyouawake"
cask "keka"
cask "localsend"
cask "maccy"
cask "monitorcontrol"
cask "obsidian"
cask "omnidisksweeper"
cask "popsql"
cask "postman"
cask "raycast"
cask "rectangle"
cask "soundsource"
cask "stats"
cask "steam"
cask "ticktick"
cask "visual-studio-code"
cask "warp"
cask "whatsapp"

# --- VS Code Extensions ---
vscode "jotacode.nightly-wolf-theme"
vscode "ms-azuretools.vscode-containers"
vscode "ms-azuretools.vscode-docker"
vscode "ms-ceintl.vscode-language-pack-pt-br"
vscode "ms-dotnettools.csdevkit"
vscode "ms-dotnettools.csharp"
vscode "ms-dotnettools.vscode-dotnet-runtime"
vscode "ms-vscode-remote.remote-containers"
vscode "ms-vscode-remote.remote-ssh"
vscode "ms-vscode-remote.remote-ssh-edit"
vscode "ms-vscode.remote-explorer"
vscode "pkief.material-icon-theme"
vscode "tomoki1207.pdf"
EOL
   
  # Roda o instalador
  brew bundle --file=$BREWFILE --verbose || echo_error "Failed to install dependencies from Brewfile."
}

# Main script execution
install_homebrew
brew update
brew upgrade

install_brew_dependencies

# Update and upgrade casks
echo_info "Updating and upgrading casks..."
brew update
brew upgrade --cask

# Finishing
echo_success "Installation and setup completed successfully."