# ~/.bash_aliases: included by ~/.bashrc

# Basic directory navigation
alias ..='cd ..'
alias ...='cd ../..'
alias _='cd -'
alias ~='cd ~'
alias ls='ls --color'
alias ll='ls -lh'
alias la='ls -A'
alias l='ls -CF'
alias le='less -R +C'
alias cls='clear && ll'
alias du1='du -h --max-depth=1'
# Compress the cd, ls -l series of commands.
alias lc="cl"
function cl () {
 if [ $# = 0 ]; then
  cd && l
 else
  cd "$*" && ll
 fi
}

# Common apps
alias vbash='vim -p ~/.bash_profile ~/.bashrc ~/.bash_aliases && . ~/.bash_profile'
alias v='vim'
alias sv='sudo vim'
alias untgz='tar -zxvf'
alias pwgen='pwgen -A -B -n'

# Mac OSX
alias funhide='defaults write com.apple.finder AppleShowAllFiles TRUE; killall Finder'
alias fhide='defaults write com.apple.finder AppleShowAllFiles FALSE; killall Finder'
alias port='sudo port'

# Ruby
# Turns out this messes with how Shoes installs gems :(
#alias gem='sudo gem' # Prefer this to --no-user-install or denying write to ~/.gem
alias gemsrv='gem server -d $HOME/.gem/ruby/1.8'

# Rails
alias ssp='ruby script/spin'
alias ss='ruby script/server'
alias sg='ruby script/generate'
alias sp='ruby script/plugin'
alias sc='ruby script/console'
alias sdbc='ruby script/dbconsole -p'
alias rdbm='rake db:migrate'
alias rr='rake routes'
alias tlog='tail -fn 300 log/development.log'

# History
alias h="history|grep "
function h() {
  if [ -z "$1" ]
  then
    history | grep -v "  h" | sed 's/[ \t]*$//' | sort -k 2 -r | uniq -f 1 | sort -n
  else
    history | grep -v "  h" | grep $1 | sed 's/[ \t]*$//' | sort -k 2 -r | uniq -f 1 | sort -n
  fi
}

# Git
alias ga='git add'
alias gb='git branch -a -v'
alias gbd='git branch -d'
alias gbr='git checkout -b'
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
alias gd='git diff --color-words'
alias gdc='git diff --color-words --cached'
alias gdv='GIT_PAGER=$VIMRUNTIME/macros/less.sh git diff --no-color'
alias gl='git log --abbrev-commit'
alias gmv='git mv'
alias gp='git push'
alias grm='git rm'
alias gs='git status'
alias git_remove_missing_files="gs | awk '/deleted:(.*)/ {print $3}' | xargs git rm"
 
# Aptitude
alias sa='sudo aptitude'
alias sai='sudo aptitude install'
alias sau='sudo aptitude update'

bind "set completion-ignore-case on"

# MySQL
alias myup='sudo mysqld_safe --user=mysql &'
alias mydown='sudo mysqladmin shutdown'

# Apache
alias ap='sudo apachectl'
alias apup='sudo apachectl start'
alias apdown='sudo apachectl stop'
alias aprestart='sudo apachectl restart'
