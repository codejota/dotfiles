# dotfiles

### Criar links simbolicos

```shell
ln -s ~/.dotfiles/.zshrc ~/.zshrc
ln -s ~/.dotfiles/.gitconfig ~/.gitconfig
```

### Remove dock lag (2 monitors)

```shell
defaults write com.apple.dock autohide-time-modifier -int 0;killall Dock
```

### Install Brew

```shell
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> /Users/jota/.profile && eval "$(/opt/homebrew/bin/brew shellenv)"
brew bundle --file ~/.dotfiles/Brewfile
```

### Install node

```shell
brew install node
```

instalações?

### Oh My Zsh

```shell

```

brew install --cask font-powerline-symbols
rew install wget

## How to extract current installed files?

```sh
cd ~/.dotfiles && brew bundle dump --force && git add . && git commit -m "update $(date +"%Y-%m-%d")" && git push
```
