#!/bin/bash
#
# Install Homebrew and applications
# Check out https://brew.sh for more details
# Comment (with #) what should not be installed and add the applications you want to install.

source ./scripts/utils.sh

echo_info "Installing apps..."

# Install Rosetta for Apple Silicon hardware
if [[ `uname -p` == 'arm' ]]; then
  softwareupdate --install-rosetta --agree-to-license
fi

# Install Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
brew update
brew upgrade

echo_info "Installing asdf, ruby and Node..."
git clone https://github.com/excid3/asdf.git ~/.asdf
echo '. "$HOME/.asdf/asdf.sh"' >> ~/.zshrc 
echo '. "$HOME/.asdf/completions/asdf.bash"' >> ~/.zshrc 
echo 'legacy_version_file = yes' >> ~/.asdfrc 
exec $SHELL

brew install libyaml 
asdf plugin add ruby 
asdf plugin add nodejs

asdf install ruby 3.3.3
asdf global ruby 3.3.3 
gem update --system

asdf install nodejs
asdf global nodejs 

gem install rails
rails -v

# Install Homebrew taps
TAPS=(
  homebrew/cask-fonts
  homebrew/cask-versions
  homebrew/command-not-found
)

for tap in ${TAPS[@]}
do
  brew tap $tap
done

# Install Homebrew formulas
FORMULAS=(
  curl
  git
  postgresql
  zsh
  gh
  wget
  powerlevel10k
  coreutils
  dockutil
)

for formula in ${FORMULAS[@]}
do
  brew install $formula
done

# Install Homebrew casks
CASKS=(
  font-jetbrains-mono
  visual-studio-code
  discord
  alt-tab
  steam
  warp
  maccy
  soundsource
  xnip
  github
  displaylink
  obsidian
  dozer
  rectangle
  raycast
  ticktick
  keka
  keepingyouawake
  arc
  bitwarden
  whatsapp
  docker
  stats
  
)

for app in ${CASKS[@]}
do
  brew install --cask $app
done

# Install Homebrew Cask Upgrade
# Check out https://github.com/buo/homebrew-cask-upgrade for more details
brew tap buo/cask-upgrade
brew update
brew cu

# Finish
echo_success "Finished applications installation."
