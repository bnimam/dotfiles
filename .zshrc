alias ll="ls -la --color=auto"
alias lg="lazygit"

autoload -U compinit
compinit
source <(jj util completion zsh)

source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

eval "$(starship init zsh)"

export PATH="$HOME/.local/bin:$PATH"

