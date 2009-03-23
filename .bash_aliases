# ~/.bash_aliases: included by ~/.bashrc

# Basic directory navigation
alias ..='cd ..'
alias ...='cd ../..'
alias _='cd -'
alias ls='ls --color'
alias ll='ls -l'
alias la='ls -A'
alias l='ls -CF'
alias le='less -R +C'
alias cls='clear && ll'
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
alias vbash='vim -p ~/.bash_profile ~/.bashrc ~/.bash_aliases && source ~/.bash_profile'
alias v='vim'
alias sv='sudo vim'
alias untgz='tar -zxvf'
alias f='find . | grep '
alias p='ps aux | grep '
alias pwgen='pwgen -A -B -n 6'

# Discover candidates for bash aliases based on usage history
alias htop='cut -f1 -d" " .bash_history | sort | uniq -c | sort -nr | head -n 30'

# Ruby
alias gem='sudo gem' # Prefer this to --no-user-install or denying write to ~/.gem

# Rails
alias spin='ruby script/spin'
alias migrate='rake db:migrate'
alias server='ruby script/server -p 40000'
alias generate='ruby script/generate'
alias plugin='ruby script/plugin'
alias console='ruby script/console'
alias routes='rake routes'
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
alias gch='git checkout'
function gch() {
  if [ -z "$1" ]
  then
    git checkout master
  else
    git checkout $1
  fi
} 
alias gco='git commit -m'
alias gd='git diff --color'
alias gl='git log'
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
