alias ll="ls -la --color=auto"

autoload -U compinit
compinit
source <(jj util completion zsh)

source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

eval "$(starship init zsh)"
