function provision() {
  ansible-galaxy install -vvv -r ~/.provision/requirements.yaml # --force to reinstall roles
  ansible-playbook -K ~/.provision/playbook.yml
}

# Basic directory navigation
alias ..='cd ..'
alias ls='ls --color=auto'
alias lh='ls -lh'
alias la='ls -A'
alias lah='ls -lAh'
alias l='ls -CF'
alias cls='clear && ll'
alias du1='du -h --max-depth=1'
alias lc="llm cmd"
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
function h() {
  if [ -z "$1" ]
  then
    history
  else
    history | grep "$1"
  fi
}

# Git
alias g='git'
alias fix='git diff --name-only | uniq | xargs $EDITOR -o'
alias ga='git add'
alias gb='g b'
alias gba='git branch -a -v'
alias gbd='git branch -d'
alias gbr='git checkout -b'
alias gbl='git blame -w -M'
function gch() {
  if [ -z "$1" ]
  then
    git checkout $(git symbolic-ref refs/remotes/origin/HEAD 2>/dev/null | sed 's@^refs/remotes/origin/@@' || echo master)
  else
    git checkout "$@"
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
function update_submodules() {
  # Pull latest changes from the default branch (main/master)
  git submodule foreach 'git checkout $(git symbolic-ref --short refs/remotes/origin/HEAD | sed "s@^origin/@@"); git pull origin $(git symbolic-ref --short refs/remotes/origin/HEAD | sed "s@^origin/@@")'

  # Initialize and update all submodules
  git submodule update --init --recursive
}
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

generate_test_videos() {
  local n=${1:-5}  # Default to 5 videos if no argument is given
  for ((i=1; i<=n; i++)); do
    ffmpeg -f lavfi -i color=c=black:s=320x240:d=2 -vf "
      drawtext=text='$i':
      x=w/2+20*sin(2*PI*t):
      y=h/2+20*cos(2*PI*t):
      fontsize=60:
      fontcolor=white" \
      -c:v libx264 -t 2 -pix_fmt yuv420p "test_$i.mp4"
  done
}

generate_test_images() {
  local n=${1:-5}  # Default to 5 images if no argument is given
  for ((i=1; i<=n; i++)); do
    ffmpeg -f lavfi -i color=c=black:s=320x240 -vf "
      drawtext=text='$i':
      x=(w-text_w)/2:
      y=(h-text_h)/2:
      fontsize=60:
      fontcolor=white" \
      -frames:v 1 "test_$i.png"
  done
}

s3gir() {
  local BUCKET="s3://backup-rtl"
  for path in "$@"; do
    if [ -d "$path" ]; then
      aws s3 cp "$path" "$BUCKET/" --recursive --storage-class GLACIER_IR
    else
      aws s3 cp "$path" "$BUCKET/" --storage-class GLACIER_IR
    fi
  done
}

alias mdev='MISE_ENV=dev mise x --'
alias mstaging='MISE_ENV=staging mise x --'
alias mprod='MISE_ENV=prod mise x --'
