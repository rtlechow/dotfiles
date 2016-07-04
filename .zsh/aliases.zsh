function provision() {
  ansible-galaxy install -p ~/.provision/vendor -r ~/.provision/requirements.yaml
  ansible-playbook -K ~/.provision/playbook.yml
}

# Basic directory navigation
alias ..='cd ..'
alias ...='../..'
alias  ....='../../..'
alias .....='../../../..'
alias ls='ls --color=auto'
alias lh='ls -lh'
alias la='ls -A'
alias lah='ls -lAh'
alias l='ls -CF'
alias le='less -R +C'
alias cls='clear && ll'
alias du1='du -h --max-depth=1'
alias lc="cl"
function cl() {
 if [ $# = 0 ]; then
  cd && ls
 else
  cd "$*" && lh
 fi
}

# Common apps
alias a='ack'
alias g='grep -Ir'
alias p='ps aux | grep'
alias d='curl dict://dict.org/d:'
alias v='vim'
alias sv='sudo vim'
alias untgz='tar -zxvf'
alias pwgen='pwgen -A -B -n'
alias irc='ssh irc -t tmux a'

# Mac OSX
alias funhide='defaults write com.apple.finder AppleShowAllFiles TRUE; killall Finder'
alias fhide='defaults write com.apple.finder AppleShowAllFiles FALSE; killall Finder'

# Ruby
alias be='bundle exec'

# Rails
alias sr='script/rails'

# History
alias h="history | grep "
function h() {
  if [ -z "$1" ]
  then
    history | grep -v "  h" | sed 's/[ \t]*$//' | sort -k 2 -r | uniq -f 1 | sort -n
  else
    history | grep -v "  h" | grep $1 | sed 's/[ \t]*$//' | sort -k 2 -r | uniq -f 1 | sort -n
  fi
}

# Git
alias fix='git diff --name-only | uniq | xargs $EDITOR'
alias gda='git branch --merged | grep -v "\*" | grep -v master | grep -v dev | xargs -n 1 git branch -d'
alias ga='git add'
alias gb='git branch -v'
alias gba='git branch -a -v'
alias gbd='git branch -d'
alias gbr='git checkout -b'
alias gbl='git blame'
alias gch='git checkout'
function gch() {
  if [ -z "$1" ]
  then
    git checkout master
  else
    git checkout $1
  fi
}
alias gco='git commit -v -m'
alias gca='git commit -a -v -m'
alias gd='git diff'
alias gdc='git diff --cached'
alias gl='git log'
alias gmv='git mv'
alias gp='git pull'
alias gps='git push'
alias grm='git rm'
alias gs='git status'
alias git_remove_missing_files="gs | awk '/deleted:(.*)/ {print $3}' | xargs git rm"

# Postgres
alias -g pgup='pg_ctl -D /usr/local/var/postgres -l /usr/local/var/postgres/server.log start'
alias -g pgdown='pg_ctl -D /usr/local/var/postgres stop -s -m fast'

# MySQL
alias -g myup='mysql.server start'
alias -g mydown='mysql.server stop'

# Apache
alias -g ap='sudo apachectl'
alias -g apup='sudo apachectl start'
alias -g apdown='sudo apachectl stop'
alias -g aprestart='sudo apachectl restart'

# Aptitude
alias sa='sudo aptitude'
alias sai='sudo aptitude install'
alias sau='sudo aptitude update'

function f() {
  if [ ! -z $1 ]; then
    find . -name "*${*}*"
  fi
}
function gg() {
  if [ ! -z $1 ]; then
    grep -Irl $1 . | xargs grep --color=auto -I $2
  fi
}