#!/bin/bash
#
# Zsh configuration file

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# --------------------------- Homebrew Setup (Universal) ----------------
# Detecta onde o brew está instalado (Intel vs Silicon)
if [ -f "/opt/homebrew/bin/brew" ]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
elif [ -f "/usr/local/bin/brew" ]; then
  eval "$(/usr/local/bin/brew shellenv)"
fi

# --------------------------- Paths ------------------------------------
export ZSH=$HOME/.oh-my-zsh
export PATH="$(brew --prefix)/opt/curl/bin:$PATH"
export PATH="$(brew --prefix)/opt/ruby/bin:$PATH"

# --------------------------- Plugins ----------------------------------
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
HB_CNF_HANDLER="$(brew --prefix)/Library/Taps/homebrew/homebrew-command-not-found/handler.sh"
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

# Tenta carregar o tema spaceship se existir
if [ -f "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" ]; then
    source "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme"
fi

# --------------------------- Aliases ----------------------------------
alias cleanup="brew cleanup"
alias copyssh="pbcopy < ~/.ssh/id_ed25519.pub | echo '=> Public key copied to pasteboard.'"
alias gitcfg="code ~/.gitconfig"
alias macupdate="sudo softwareupdate -ia"
alias update="brew update && brew upgrade && brew cu --all"
alias npmcheck="npm outdated -g --depth=0"
alias npmlist="npm list -g --depth=0"
alias npmupdate="npm update -g"
alias uncommit="git reset HEAD~1"
alias zshcfg="code ~/.zshrc"

# --------------------------- ASDF -------------------------------------
# Carrega ASDF usando o prefixo do Brew (funciona em ambos)
if [ -f "$(brew --prefix asdf)/libexec/asdf.sh" ]; then
    . "$(brew --prefix asdf)/libexec/asdf.sh"
fi

# --------------------------- Spaceship Config -------------------------
SPACESHIP_PROMPT_ORDER=(
  user dir host git hg exec_time jobs exit_code char line_sep node docker
)

SPACESHIP_USER_SHOW=always
SPACESHIP_CHAR_SYMBOL="❯"
SPACESHIP_CHAR_SUFFIX=" "
SPACESHIP_TIME_SHOW=true
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

# --------------------------- PNPM -------------------------------------
export PNPM_HOME="$HOME/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac

# --------------------------- Extra Functions --------------------------
ccm() {
  git diff | cody chat --stdin -m 'Write a commit message for this diff:'
}