#!/bin/bash
#
# mascOS setup script
# Main install script

source ./scripts/utils.sh

# Add your data
echo_info "Add your data:"
nano ./scripts/user.sh
source ./scripts/user.sh


# Install apps
bash ./scripts/apps.sh

# Install dotfiles
bash ./scripts/dotfiles.sh

# Run macOS defaults
bash ./scripts/macos.sh

# Dock settings
bash ./scripts/dock.sh

# Generate SSH key
if [[ $SSH_EMAIL ]]; then
  bash ./scripts/ssh.sh
fi

# Set hostname
if [[ $HOSTNAME ]]; then
  bash ./scripts/hostname.sh
fi

# Create a directory for projects and development
echo_info "Creating Developer directory in Home."
mkdir ${HOME}/dev

# Cleanup cached downloads and remove the installation zip and folder
echo_info "Removing unnecessary files."
brew cleanup


# Finish
echo_success "Reboot and enjoy!"
