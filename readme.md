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

# Fish

Shell. Config mirrors CachyOS fish setup (`fish/config.fish`).

```shell
brew install fish
```

Make it the default shell:

```shell
echo (which fish) | sudo tee -a /etc/shells
chsh -s (which fish)
```

## eza (optional)

Powers the CachyOS-style `ls`/`ll`/`la`/`lt` aliases. Without it, `ll`/`la`
fall back to plain `ls`.

```shell
brew install eza
```

## fastfetch (optional)

Shown as the fish greeting, like CachyOS.

```shell
brew install fastfetch
```

## Starship

Fancy cross-shell prompt. Initialized in `fish/config.fish`.

```shell
brew install starship
```

## Ghostty

Good terminal emulator built on zig

MacOS

```shell
brew install --cask ghostty
```

Other

```shell
snap install ghostty --classic
```

## Neovim

My IDE, config is mostly stock nvchad

```bash
brew install neovim
```

## Symlink it all

```shell
sudo rm -rf ~/.local/state/nvim
sudo rm -rf ~/.local/share/nvim
ln -s ~/dotfiles/nvim ~/.config/nvim
mkdir -p ~/.config/ghostty
ln -s ~/dotfiles/ghostty/config ~/.config/ghostty/config
ln -sf ~/dotfiles/.tmux.conf ~/.tmux.conf
mkdir -p ~/.config/fish
ln -sf ~/dotfiles/fish/config.fish ~/.config/fish/config.fish
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
