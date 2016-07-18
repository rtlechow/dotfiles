shdir=~/.zsh
configs=(
  env.sh
  options.zsh
  aliases.zsh
  ../.localrc
)
for f in $configs; do
  [[ -f $shdir/$f ]] && . $shdir/$f
done

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}' # case insensitive completion
zstyle ':completion:*:cd:*' ignore-parents parent pwd # cd will never select the parent directory (e.g.: cd ../<TAB>)
zstyle ':completion:*' completer _expand _complete

autoload -Uz compaudit compinit && compinit
autoload -Uz colors && colors

eval `dircolors ~/.dir_colors`

fpath=(~/.zsh/functions $fpath)
autoload -U ~/.zsh/functions/*(:t)
source ~/.zsh/functions/_git_prompt
source ~/.zsh/functions/rake-fast.plugin.zsh

export PS1='${fg[magenta]}%m${fg[white]}:${fg[cyan]}%1~${fg[white]}`git-prompt`${fg[white]}%# '

export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

export NVM_DIR="$HOME/.nvm"
source "$(brew --prefix nvm)/nvm.sh"
