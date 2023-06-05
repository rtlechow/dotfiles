typeset -U path manpath gem_home gem_path

path=(~/.bin /usr/local/bin /usr/local/sbin $path)
path=(/opt/homebrew/opt/coreutils/libexec/gnubin $path)
path=(/opt/homebrew/opt/gnu-sed/libexec/gnubin $path)
path=(/opt/homebrew/opt/mysql@5.7/bin $path) # New Homebrew path; mysql@5.7 doesn't get symlinked
path=(/usr/local/opt/coreutils/libexec/gnubin $path)
path=(/usr/local/opt/mysql-client/bin $path)
path=($GOPATH/bin $path)

manpath=(/usr/local/opt/coreutils/libexec/gnuman/ $manpath)
manpath=(/opt/homebrew/opt/coreutils/libexec/gnuman/ $manpath)

cdpath=(~/src $cdpath)

HISTFILE=~/.zsh_history
HISTIGNORE='k:ls:lm:bg:fg:jobs:pwd:kill:declare:history:cd:cd :&: *:'
HISTSIZE=10000
REPORTTIME=10
SAVEHIST=10000

setopt autopushd
setopt nobeep
setopt nobgnice
setopt nohup
setopt nolistbeep
setopt localoptions
setopt localtraps
setopt promptsubst
setopt correct
setopt completeinword
setopt ignoreeof
setopt autocd
setopt extendedglob
setopt globdots
setopt menu_complete

# History
setopt appendhistory
setopt incappendhistory
setopt sharehistory
setopt histverify
setopt nohistbeep
setopt extendedhistory
setopt histignorealldups
setopt histignorespace
setopt histreduceblanks
setopt histverify

# Disable C-s C-q for use on other bindings
# https://coderwall.com/p/ltiqsq
stty stop ''
stty start ''
stty -ixon
stty -ixoff

bindkey -v
bindkey 'jj' vi-cmd-mode
bindkey -M viins '^a' vi-beginning-of-line
bindkey -M viins '^e' vi-end-of-line
bindkey '^[[z' reverse-menu-complete
bindkey -M viins '^r' history-incremental-search-backward
bindkey '^p' up-history
bindkey '^n' down-history
bindkey '^w' backward-kill-word
