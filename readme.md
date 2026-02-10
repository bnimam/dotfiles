# Install Instructions (MacOS)

## This repo

Must be cloned into the root of the home dir so that
~/dotfiles is valid.

## Homebrew

```shell
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

## Python

```shell
brew update
brew install python3
brew link python3
```

Then restart shell

## Jujutsu (jj)

```shell
brew install jj
```

## nerd font

```shell
brew install --cask font-0xProto-nerd-font
```

## zsh starship

```shell
brew install starship
```

## zsh syntax highlighting

```shell
brew install zsh-syntax-highlighting
```

## symlink it all

```shell
cd ~/dotfiles
rm ~/.zshrc
rm ~/.config/starship.toml
ln -sf ~/dotfiles/.zshrc ~/.zshrc
ln -sf ~/dotfiles/starship.toml ~/.config/starship.toml
```
