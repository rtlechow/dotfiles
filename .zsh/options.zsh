typeset -U path manpath gem_home gem_path
path=(~/.bin /usr/local/bin $path)
path=($(brew --prefix coreutils)/libexec/gnubin $path)
manpath=($(brew --prefix coreutils)/libexec/gnuman/ $manpath)
cdpath=(~/src ~/Dropbox ~/src/work $cdpath)

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
bindkey '^A' vi-beginning-of-line
bindkey '^E' vi-end-of-line