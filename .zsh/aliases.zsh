function provision() {
  ansible-galaxy install -vvv -r ~/.provision/requirements.yaml # --force to reinstall roles
  ansible-playbook -K ~/.provision/playbook.yml
}

# Basic directory navigation
alias ..='cd ..'
alias ...='../..'
alias ls='ls --color=auto'
alias lh='ls -lh'
alias la='ls -A'
alias lah='ls -lAh'
alias l='ls -CF'
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
alias b='bundle'
alias dc='docker-compose'
alias dcl='docker-compose logs -f --tail 10'
alias dm='docker-machine'
alias kp='keepassxc-cli'
alias p='ps aux | grep -v grep | grep -E'
function d() {
  curl dict://dict.org/d:$1 | less
}
alias tl='tail -f log/*'
alias v='vim'
alias sv='sudo vim'
alias s='ssh'
alias untgz='tar -zxvf'
alias pwgen='pwgen -A -B -n'
alias pw='printf "%s-%s-%s-%s\n" $(grep -v "[A-Z]" /usr/share/dict/words | shuf -n 4)'
alias irc='ssh irc -t tmux a'
alias -g A='| ack '

# Mac OSX
alias funhide='defaults write com.apple.finder AppleShowAllFiles TRUE; killall Finder'
alias fhide='defaults write com.apple.finder AppleShowAllFiles FALSE; killall Finder'
alias battery='ioreg -r -l -k "BatteryPercent" | egrep "BatteryPercent|Product\""'

# Ruby
alias be='bundle exec'

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
alias g='git'
eval "$(hub alias -s)"
alias fix='git diff --name-only | uniq | xargs $EDITOR -o'
alias ga='git add'
alias gb='g b'
alias gba='git branch -a -v'
alias gbd='git branch -d'
alias gbr='git checkout -b'
alias gbl='git blame -w -M'
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
alias gs='git status -sb'
alias git_remove_missing_files="gs | awk '/deleted:(.*)/ {print $3}' | xargs git rm"
alias update_submodules='git submodule foreach "git pull origin"'
alias gdelsquashed='npx @teppeis/git-delete-squashed'
function git-delete-squashed() {
  if [[ $* =~ 'dry' ]]
  then
    echo "Dry run"
    git checkout -q master && git for-each-ref refs/heads/ "--format=%(refname:short)" | while read branch; do mergeBase=$(git merge-base master $branch) && [[ $(git cherry master $(git commit-tree $(git rev-parse $branch^{tree}) -p $mergeBase -m _)) == "-"* ]] && echo $branch; done
  else
    read -q "REPLY?Wet run, continue?"
    if [[ $REPLY =~ ^[Yy]$ ]]
    then
      echo 'Continuing'
      git checkout -q master && git for-each-ref refs/heads/ "--format=%(refname:short)" | while read branch; do mergeBase=$(git merge-base master $branch) && [[ $(git cherry master $(git commit-tree $(git rev-parse $branch\^{tree}) -p $mergeBase -m _)) == "-"* ]] && git branch -D $branch; done
    else
      echo 'Aborting'
    fi
  fi
}
function git_largest() {
  git rev-list --objects --all \
  | git cat-file --batch-check='%(objecttype) %(objectname) %(objectsize) %(rest)' \
  | awk '/^blob/ {print substr($0,6)}' \
  | sort --numeric-sort --key=2 \
  | cut --complement --characters=13-40 \
  | numfmt --field=2 --to=iec-i --suffix=B --padding=7 --round=nearest
}

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
    find . -not -iwholename '*.git*' -name "*${*}*"
  fi
}
function gg() {
  if [ ! -z $1 ]; then
    grep -Irl $1 . | xargs grep --color=auto -I $2
  fi
}

alias icat='imgcat'
alias isvg='rsvg-convert | icat'
alias idot='dot -Efontsize=18 -Efontname=sans -Nfontname=sans -Tpng -Gbgcolor=black -Gcolor=white -Ecolor=white -Efontcolor=white -Ncolor=white -Nfontcolor=white | icat'
