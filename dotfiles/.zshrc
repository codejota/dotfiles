#!/bin/bash
#
# Zsh configuration file

if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi 
# --------------------------- Paths ------------------------------------
# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Homebrew path
export PATH="/opt/homebrew/bin:$PATH"

# curl path
export PATH="/opt/homebrew/opt/curl/bin:$PATH"

# Ruby path
export PATH="/opt/homebrew/opt/ruby/bin:$PATH"
export PATH="$(gem environment gemdir)/bin:$PATH"

# --------------------------- Plugins ----------------------------------
# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
    git
    ruby
    docker
    asdf
    zsh-autosuggestions
    zsh-completions 
    zsh-history-substring-search 
    zsh-syntax-highlighting
    zsh-navigation-tools
)

# Homebrew Command Not Found
HB_CNF_HANDLER="/opt/homebrew/Library/Taps/homebrew/homebrew-command-not-found/handler.sh"
if [ -f "$HB_CNF_HANDLER" ]; then
  source "$HB_CNF_HANDLER";
fi

# Homebrew Shell Completion
if type brew &>/dev/null; then
  FPATH=$(brew --prefix)/share/zsh/site-functions:$FPATH
fi

source $ZSH/oh-my-zsh.sh

# --------------------------- Theme ------------------------------------
ZSH_THEME="spaceship"
  source $ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme

# ZSH_THEME="powerlevel10k/powerlevel10k"
# source $HOMEBREW_PREFIX/share/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# --------------------------- Aliases ----------------------------------
# Cleanup Homebrew and Cask cache
alias cleanup="brew cleanup"

# Copy SSH
alias copyssh="pbcopy < ~/.ssh/id_ed25519.pub | echo '=> Public key copied to pasteboard.'"

# Open .gitconfig in VSCode
alias gitcfg="code ~/.gitconfig"

# Update macOS using Command Line Software Update Tool
alias macupdate="sudo softwareupdate -ia"

# Update Homebrew and Cask formulaes
# Include -f to update apps that are marked as latest
alias update="brew update && brew upgrade && brew cu --all"

# List outdated npm packages installed globally
alias npmcheck="npm outdated -g --depth=0"

# List npm packages installed globally
alias npmlist="npm list -g --depth=0"

# Update npm packages installed globally
alias npmupdate="npm update -g"

# Undo the last commit
alias uncommit="git reset HEAD~1"

# Open .zshrc in VSCode
alias zshcfg="code ~/.zshrc"

. "$HOME/.asdf/asdf.sh"
. "$HOME/.asdf/completions/asdf.bash"




SPACESHIP_PROMPT_ORDER=(
  user          # Username section
  dir           # Current directory section
  host          # Hostname section
  git           # Git section (git_branch + git_status)
  hg            # Mercurial section (hg_branch  + hg_status)
  exec_time     # Execution time
  jobs          # Background jobs indicator
  exit_code     # Exit code section
  char          # Prompt character
  line_sep      # Line break
  node          # Node.js section
  docker        # Docker section
)

SPACESHIP_USER_SHOW=always
SPACESHIP_CHAR_SYMBOL="❯"
SPACESHIP_CHAR_SUFFIX=" "
SPACESHIP_TIME_SHOW=true
SPACESHIP_USER_SHOW=always
SPACESHIP_DIR_TRUNC_REPO=false
SPACESHIP_DIR_TRUNC=1
SPACESHIP_DIR_FIRST=false
SPACESHIP_RUBY_SUFFIX="❯"
SPACESHIP_RUBY_COLOR="red"
SPACESHIP_NODE_SHOW=true
SPACESHIP_NODE_SUFFIX=" ➜ "
SPACESHIP_NODE_PREFIX=""
SPACESHIP_NODE_COLOR="green"

export SPACESHIP_CONFIG="$HOME/.dotfiles/spaceship/spaceship.zsh"
export PATH=$PATH:/Library/PostgreSQL/17/bin
export PATH="/opt/homebrew/bin:$PATH"
export PATH="/usr/local/opt/python@3.12/bin:$PATH"
export PATH="/opt/homebrew/opt/python@3.12/bin:$PATH"
export PATH="/usr/local/opt/tcl-tk/bin:$PATH"
export LDFLAGS="-L/usr/local/opt/tcl-tk/lib"
export CPPFLAGS="-I/usr/local/opt/tcl-tk/include"


export PNPM_HOME="/Users/jota/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac

# aliases 
ccm() {
  git diff | cody chat --stdin -m 'Write a commit message for this diff:'
}
# pnpm
export PNPM_HOME="/Users/jota/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
