# dotfiles

## This is my first experience with macOS and also configuring dotfiles

### Create Symbol link

```shell
ln -s ~/.dotfiles/dotfiles/.zshrc ~/.zshrc
ln -s ~/.dotfiles/dotfiles/.zprofile ~/.zprofile
ln -s ~/.dotfiles/dotfiles/.gitconfig ~/.gitconfig
ln -s ~/.dotfiles/dotfiles/.p10k.zsh  ~/.p10k.zsh
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

### Oh My Zsh

```shell
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions\
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting\
git clone https://github.com/zsh-users/zsh-completions.git ~/.oh-my-zsh/custom/plugins/zsh-completions\
git clone https://github.com/zsh-users/zsh-history-substring-search.git ~/.oh-my-zsh/custom/plugins/zsh-history-substring-search\

git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

```

## How to extract current installed files?

```sh
cd ~/.dotfiles && brew bundle dump --force && git add . && git commit -m "update $(date +"%Y-%m-%d")" && git push
```
