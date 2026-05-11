alias ll="ls -la --color=auto"
alias lg="lazygit"

autoload -U compinit
compinit

if [[ "$(uname)" == "Linux" ]]; then
  # Linuxbrew
  export PATH="/home/linuxbrew/.linuxbrew/bin:/home/linuxbrew/.linuxbrew/sbin:$PATH"
  export HOMEBREW_PREFIX="/home/linuxbrew/.linuxbrew"

  # Ubuntu/Debian PATH additions that may not be set in non-login shells
  export PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin:$PATH"

  # XDG and snap desktop integration
  export XDG_DATA_DIRS="${XDG_DATA_DIRS:-/usr/local/share:/usr/share}:/var/lib/snapd/desktop"

  # Colors for ls via dircolors
  if [[ -x /usr/bin/dircolors ]]; then
    if [[ -r "$HOME/.dircolors" ]]; then
      eval "$(dircolors -b "$HOME/.dircolors")"
    else
      eval "$(dircolors -b)"
    fi
  fi

  # Colored grep
  alias grep='grep --color=auto'
  alias fgrep='fgrep --color=auto'
  alias egrep='egrep --color=auto'

  # command-not-found handler (suggests apt packages for unknown commands)
  [[ -f /etc/zsh_command_not_found ]] && source /etc/zsh_command_not_found
fi

source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

eval "$(starship init zsh)"

export PATH="$HOME/.local/bin:$PATH"

