#!/bin/bash
#
# Command line tool for managing dock items
# Check out https://github.com/kcrawford/dockutil for more details
# Configure apps you want to set in dock

source ./scripts/utils.sh

echo_info "Setting Dock..."

# Install dockutil
# brew install dockutil
# Temporary fix:
brew install dockutil

# Dock settings
dockutil --no-restart --remove all
dockutil --no-restart --add "/System/Applications/Launchpad.app"
dockutil --no-restart --add "/System/Applications/Obsidian.app"
dockutil --no-restart --add "/Applications/Arc.app"
dockutil --no-restart --add "/Applications/Visual Studio Code.app"
dockutil --no-restart --add "/Applications/Warp.app"

killall Dock

# Finish
echo_success "Dock settings updated."
