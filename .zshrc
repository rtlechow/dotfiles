typeset -U path manpath gem_home gem_path
path=(~/.bin /System/Library/Frameworks/Ruby.framework/Versions/1.8/usr/bin /usr/local/bin /usr/local/mysql/bin $path)
export EDITOR=/usr/bin/vim
export AUTOFEATURE=true

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

if [[ -r ~/.zsh/aliases ]]; then
  . ~/.zsh/aliases
fi

[ -d "$HOME/Downloads" ] && hash -d downs="$HOME/Downloads"
[ -d "$HOME/Code" ] && hash -d code="$HOME/Code"
[ -d "$HOME/Code/work" ] && hash -d work="$HOME/Code/work"
[ -d "$HOME/Desktop" ] && hash -d desk="$HOME/Desktop"
[ -d "$HOME/Documents" ] && hash -d docs="$HOME/Documents"
[ -d "$HOME/.irssi/logs" ] && hash -d irc="$HOME/.irssi/logs"

if [[ -x `which git` ]]; then
  function git-branch-name () {
    git branch 2> /dev/null | grep '^\*' | sed 's/^\*\ //'
  }
  function git-dirty () {
    git status 2> /dev/null | grep "nothing to commit (working directory clean)"
    echo $?
  }
  function gsrb () {
    branch=$(git-branch-name)
    git checkout master
    git svn rebase
    git checkout "${branch}"
    git rebase master
  }
  function git-need-to-push() {
    if pushtime=$(echo $1 | grep 'Your branch is ahead' 2> /dev/null); then
      echo "↑ "
    fi
  }
  function git-prompt() {
    gstatus=$(git status 2> /dev/null)
    branch=$(echo $gstatus | head -1 | sed 's/^# On branch //')
    dirty=$(echo $gstatus | sed 's/^#.*$//' | tail -2 | grep 'nothing to commit (working directory clean)'; echo $?)
    if [[ x$branch != x ]]; then
      dirty_color=$fg[green]
      push_status=$(git-need-to-push $gstatus 2> /dev/null)
      if [[ $dirty = 1 ]] { dirty_color=$fg[red] }
      [ x$branch != x ] && echo " %{$dirty_color%}$branch%{$reset_color%} $push_status"
    fi
  }
  function git-scoreboard () {
    git log | grep '^Author' | sort | uniq -ci | sort -r
  }
  function git-track () {
    branch=$(git-branch-name)
    git config branch.$branch.remote origin
    git config branch.$branch.merge refs/heads/$branch
    echo "tracking origin/$tracking"
  }
  function github-init () {
    git config branch.$(git-branch-name).remote origin
    git config branch.$(git-branch-name).merge refs/heads/$(git-branch-name)
  }
  function github-url () {
    git config remote.origin.url | sed -En 's/git(@|:\/\/)github.com(:|\/)(.+)\/(.+).git/https:\/\/github.com\/\3\/\4/p'
  }
  # Seems to be the best OS X jump-to-github alias from http://tinyurl.com/2mtncf
  function github-go () {
    open $(github-url)
  }
  function nhgk () {
    nohup gitk --all &
  }
fi

export PS1='${fg[white]}$($HOME/.rvm/bin/rvm-prompt s u p g) ${fg_bold[white]}(${fg[yellow]}%h ${fg[cyan]}%n${fg[white]}@${fg[magenta]}%m${fg[white]}:${fg[yellow]}%3~${fg[white]}`git-prompt`${reset_color}) ${fg[white]}'

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}' # case insensitive completion
zstyle ':completion:*:cd:*' ignore-parents parent pwd # cd will never select the parent directory (e.g.: cd ../<TAB>)
zstyle ':completion:*' completer _expand _complete

fpath=(~/.zsh/functions $fpath)
autoload -U ~/.zsh/functions/*(:t)

# rvm-install added:
if [[ -s $HOME/.rvm/scripts/rvm ]] ; then source $HOME/.rvm/scripts/rvm ; fi

bindkey -v
bindkey 'jj' vi-cmd-mode
bindkey '^A' vi-beginning-of-line
bindkey '^E' vi-end-of-line

# Ruby GC
export RUBY_HEAP_MIN_SLOTS=500000
export RUBY_HEAP_SLOTS_INCREMENT=250000
export RUBY_HEAP_SLOTS_GROWTH_FACTOR=1
export RUBY_GC_MALLOC_LIMIT=500000000
