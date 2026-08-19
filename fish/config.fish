## gcloud: force a supported Python (system python3 is 3.9, too old for gcloud)
if not set -q CLOUDSDK_PYTHON
    for _py in /opt/homebrew/bin/python3.11 /usr/bin/python3
        if test -x $_py
            set -gx CLOUDSDK_PYTHON $_py
            break
        end
    end
    set -e _py
end

if not status is-interactive
    exit
end

## Greeting — fastfetch like CachyOS (if installed)
function fish_greeting
    if command -q fastfetch
        fastfetch
    end
end

## Format man pages with bat (CachyOS default)
if command -q bat
    set -x MANROFFOPT "-c"
    set -x MANPAGER "sh -c 'col -bx | bat -l man -p'"
end

## PATH
fish_add_path $HOME/.local/bin $HOME/.cargo/bin
fish_add_path /usr/local/clamav/bin /usr/local/clamav/sbin

## Linux-specific setup
if test (uname) = Linux
    # Linuxbrew
    fish_add_path /home/linuxbrew/.linuxbrew/bin /home/linuxbrew/.linuxbrew/sbin
    set -x HOMEBREW_PREFIX /home/linuxbrew/.linuxbrew

    # XDG / snap desktop integration
    if not set -q XDG_DATA_DIRS
        set -x XDG_DATA_DIRS /usr/local/share /usr/share
    end
    set -x XDG_DATA_DIRS $XDG_DATA_DIRS /var/lib/snapd/desktop

    # ls colors via dircolors
    if test -x /usr/bin/dircolors
        if test -r "$HOME/.dircolors"
            eval (dircolors -c "$HOME/.dircolors" | string replace 'setenv ' 'set -x ')
        else
            eval (dircolors -c | string replace 'setenv ' 'set -x ')
        end
    end
end

## Functions for !! and !$ (CachyOS / oh-my-fish plugin-bang-bang)
function __history_previous_command
    switch (commandline -t)
        case "!"
            commandline -t $history[1]
            commandline -f repaint
        case "*"
            commandline -i !
    end
end

function __history_previous_command_arguments
    switch (commandline -t)
        case "!"
            commandline -t ""
            commandline -f history-token-search-backward
        case "*"
            commandline -i '$'
    end
end

if test "$fish_key_bindings" = fish_vi_key_bindings
    bind -Minsert ! __history_previous_command
    bind -Minsert '$' __history_previous_command_arguments
else
    bind ! __history_previous_command
    bind '$' __history_previous_command_arguments
end

## History with timestamps (CachyOS)
function history
    builtin history --show-time='%F %T ' $argv
end

## backup FILE -> FILE.bak (CachyOS)
function backup --argument filename
    cp $filename $filename.bak
end

## copy DIR1 DIR2 (CachyOS)
function copy
    set count (count $argv | tr -d \n)
    if test "$count" = 2; and test -d "$argv[1]"
        set from (echo $argv[1] | string trim --right --chars=/)
        set to (echo $argv[2])
        command cp -r $from $to
    else
        command cp $argv
    end
end

## Aliases
# Listing — eza if available (CachyOS style), else plain ls. ll shows hidden.
if command -q eza
    alias ls='eza -al --color=always --group-directories-first --icons=always'
    alias la='eza -a --color=always --group-directories-first --icons=always'
    alias ll='eza -la --color=always --group-directories-first --icons=always'
    alias lt='eza -aT --color=always --group-directories-first --icons=always'
    alias l.="eza -a | grep -e '^\.'"
else
    alias ll='ls -la --color=auto'
    alias la='ls -A --color=auto'
end

alias lg='lazygit'

# Navigation (CachyOS)
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ......='cd ../../../../..'

# Colored grep (CachyOS)
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'

# Common (CachyOS)
alias tarnow='tar -acf '
alias untar='tar -zxvf '
alias wget='wget -c '
alias psmem='ps auxf | sort -nr -k 4'
alias psmem10='ps auxf | sort -nr -k 4 | head -10'

## Starship prompt
if command -q starship
    starship init fish | source
end

# Added by OrbStack: command-line tools and integration
# This won't be added again if you remove it.
source ~/.orbstack/shell/init2.fish 2>/dev/null || :
