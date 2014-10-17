stty -ixon
typeset -U path manpath gem_home gem_path
path=(~/.bin /usr/local/bin $path)
path=($(brew --prefix coreutils)/libexec/gnubin $path)
manpath=($(brew --prefix coreutils)/libexec/gnuman/ $manpath)
cdpath=(~/code ~/Dropbox ~/code/work $cdpath)
export EDITOR='vim'
export RUBYOPT='rubygems'
export JAVA_HOME='/Library/Java/Home'

autoload -U compinit
compinit

autoload colors
colors

eval `dircolors ~/.dir_colors`
export GREP_OPTIONS='--color=auto'
export GREP_COLOR='0;32'

HISTFILE=~/.zsh_history
HISTSIZE=1000
SAVEHIST=1000
REPORTTIME=10

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

if [[ -x `which git` ]]; then
  function git-branch-name () {
    git branch 2> /dev/null | grep '^\*' | sed 's/^\*\ //'
  }
  function git-dirty () {
    git status 2> /dev/null | grep "nothing to commit.*working directory clean"
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
      echo "↑"
    fi
  }
  function git-prompt() {
    if [ "$(git rev-parse --show-toplevel)" = $HOME ]; then return; fi
    gstatus=$(git status 2> /dev/null)
    branch=$(echo $gstatus | head -1 | sed 's/^.*On branch //')
    dirty=$(echo $gstatus | sed 's/^#.*$//' | tail -2 | grep 'nothing to commit.*working directory clean'; echo $?)
    if [[ x$branch != x ]]; then
      dirty_color=$fg[green]
      push_status=$(git-need-to-push $gstatus 2> /dev/null)
      if [[ $dirty = 1 ]] { dirty_color=$fg[red] }
      [ x$branch != x ] && echo "(%{$dirty_color%}$branch%{$reset_color%}$push_status)"
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

export PS1='${fg[magenta]}%m${fg[white]}:${fg[cyan]}%1~${fg[white]}`git-prompt`${fg[white]}%# '

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}' # case insensitive completion
zstyle ':completion:*:cd:*' ignore-parents parent pwd # cd will never select the parent directory (e.g.: cd ../<TAB>)
zstyle ':completion:*' completer _expand _complete

fpath=(~/.zsh/functions $fpath)
autoload -U ~/.zsh/functions/*(:t)

bindkey -v
bindkey 'jj' vi-cmd-mode
bindkey '^A' vi-beginning-of-line
bindkey '^E' vi-end-of-line

[[ -x `which brew` && -r "`brew --prefix`/etc/grc.bashrc" ]] && source "`brew --prefix`/etc/grc.bashrc"

export PATH="$HOME/.rbenv/shims:$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"
