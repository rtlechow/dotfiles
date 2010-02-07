typeset -U path manpath gem_home gem_path
path=(~/bin ~/.gems/ruby/1.8/bin /System/Library/Frameworks/Ruby.framework/Versions/1.8/usr/bin /usr/local/mysql/bin /opt/local/libexec/git-core /opt/local/apache2/bin /opt/local/bin /opt/local/sbin $path)
manpath=($manpath /opt/local/share/man /opt/local/man)
export GEM_HOME='/Users/rtl/.gems/ruby/1.8'
export GEM_PATH='/Users/rtl/.gems/ruby/1.8'

autoload -U compinit
compinit

autoload colors
colors

export editor='vim'
ls_options='--color=auto'
eval `dircolors ~/.dir_colors`
export grep_options='--color=auto'
export grep_color='0;32'

histfile=~/.zsh_history
histsize=1000
savehist=1000
reporttime=10

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

if [[ -r ~/.zsh/aliases ]]; then
  . ~/.zsh/aliases
fi

[ -d "$HOME/Downloads" ] && hash -d downs="$HOME/Downloads"
[ -d "$HOME/Code" ] && hash -d code="$HOME/Code"
[ -d "$HOME/Desktop" ] && hash -d desk="$HOME/Desktop"
[ -d "$HOME/Documents" ] && hash -d docs="$HOME/Documents"
[ -d "$HOME/.irssi/logs" ] && hash -d irc="$HOME/.irssi/logs"

# Git Prompt
autoload -Uz vcs_info
# set formats
# %b - branchname
# %u - unstagedstr (see below)
# %c - stagedstr (see below)
# %a - action (e.g. rebase-i)
# %R - repository path
# %S - path in the repository
FMT_BRANCH="${fg[green]}%u%c%b${reset_color}" # e.g. master¹²
FMT_ACTION="${fg[white]}(${fg[red]}%a${fg[white]})"   # e.g. (rebase-i)
FMT_PATH="%R${fg[yellow]}/%S"              # e.g. ~/repo/subdir
zstyle ':vcs_info:*:prompt:*' check-for-changes true
zstyle ':vcs_info:*:prompt:*' unstagedstr "${fg[blue]}"  # display ¹ if there are unstaged changes
zstyle ':vcs_info:*:prompt:*' stagedstr "${fg[red]}"    # display ² if there are staged changes
zstyle ':vcs_info:*:prompt:*' actionformats "${FMT_BRANCH}${FMT_ACTION}" "${FMT_PATH}"
zstyle ':vcs_info:*:prompt:*' formats       "${FMT_BRANCH}"              "${FMT_PATH}"
zstyle ':vcs_info:*:prompt:*' nvcsformats   ""                           "%~"
precmd() {
  vcs_info 'prompt'
}
export PS1='${fg[white]}$(/Users/rtl/.rvm/bin/rvm-prompt i v) ${fg_bold[white]}(${fg[yellow]}%h ${fg[green]}%n${fg[white]}@${fg[green]}%m${fg[white]}:${fg[yellow]}%3~${fg[white]} $vcs_info_msg_0_${reset_color}) ${fg[white]}'

zstyle ':completion:*:cd:*' ignore-parents parent pwd # cd will never select the parent directory (e.g.: cd ../<TAB>)
zstyle ':completion:*' completer _expand _complete

fpath=(~/.zsh/functions $fpath)
autoload -U ~/.zsh/functions/*(:t)

# rvm-install added:
if [[ -s /Users/rtl/.rvm/scripts/rvm ]] ; then source /Users/rtl/.rvm/scripts/rvm ; fi
