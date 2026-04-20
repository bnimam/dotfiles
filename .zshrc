alias ll="ls -la --color=auto"

autoload -U compinit
compinit
source <(jj util completion zsh)

source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

eval "$(starship init zsh)"

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh" || true

export PATH="$HOME/.local/bin:$PATH"

