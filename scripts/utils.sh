#!/bin/bash
#
# Some functions used in install scripts

source ./scripts/user.sh

# Global variables
DOTFILES_DIRECTORY="$PWD"

ARCH=$(uname -m)
if [[ "$ARCH" == "arm64" ]]; then
  # Apple Silicon (M1/M2/M3)
  HOMEBREW_PREFIX="/opt/homebrew"
else
  # Intel (Hackintosh/Macs Antigos)
  HOMEBREW_PREFIX="/usr/local"
fi

 export PATH="$HOMEBREW_PREFIX/bin:$PATH"

# Info message
echo_info() {
  printf "\n$(tput setaf 3)%s$(tput sgr0)\n" "$@"
  sleep 2
}

# Success message
echo_success() {
  printf "\n$(tput setaf 2)✓ %s$(tput sgr0)\n" "$@"
  sleep 2
}

# Warning message
echo_warning() {
  printf "\n$(tput setaf 136)! %s$(tput sgr0)\n" "$@"
  sleep 2
}

# Force move/replace files
replace() {
  cp -f "${DOTFILES_DIRECTORY}/${1}" "${HOME}/${2}"
}