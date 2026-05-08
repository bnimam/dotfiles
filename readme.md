# Install Instructions

## This repo

Must be cloned into the root of the home dir so that
~/dotfiles is valid.

## Homebrew

Best package manager, works on linux, wsl2, and macos

```shell
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

## Python

Python3 is required for some of this stuff

```shell
brew update
brew install python3
brew link python3
```

## Nerd font

Starship requires a nerd font

```shell
brew install --cask font-0xProto-nerd-font
```

## Zsh starship

Fancy pre-configed zsh setup

```shell
brew install starship
```

## Zsh syntax highlighting

Live syntax highlighting while typing terminal commands

```shell
brew install zsh-syntax-highlighting
```

## Ghostty

Good terminal emulator built on zig

```shell
brew install --cask ghostty
```

## Neovim

My IDE, config is mostly stock nvchad

```bash
brew install neovim
```

## Symlink it all

```shell
cd ~/dotfiles
rm ~/.zshrc
rm ~/.config/starship.toml
sudo rm -rf ~/.local/state/nvim
sudo rm -rf ~/.local/share/nvim
ln -sf ~/dotfiles/.zshrc ~/.zshrc
ln -sf ~/dotfiles/starship.toml ~/.config/starship.toml
ln -s ~/dotfiles/nvim ~/.config/nvim
ln -s ~/dotfiles/ghostty.config ~/.config/ghostty.config
```
# Other Stuff

Useful things

## LinearMouse (macos)

Makes mouse usable on mac.

```bash
brew install --cask linearmouse
```

## OrbStack

Lightweight Docker / VM / K8s emulator.

```bash
brew install orbstack
```

## Kind

Lightweight K8s emulator.

```bash
brew install kind
```

## Lazygit

Best git TUI in existance.

```bash
brew install lazygit
```
