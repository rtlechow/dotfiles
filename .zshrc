shdir=~/.zsh
configs=(
  env.sh
  options.zsh
  aliases.zsh
)
for f in $configs; do
  [[ -f $shdir/$f ]] && . $shdir/$f
done
if [[ -a ~/.localrc ]]
then
  source ~/.localrc
fi

autoload -U compinit
compinit

autoload colors
colors

eval `dircolors ~/.dir_colors`

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}' # case insensitive completion
zstyle ':completion:*:cd:*' ignore-parents parent pwd # cd will never select the parent directory (e.g.: cd ../<TAB>)
zstyle ':completion:*' completer _expand _complete

fpath=(~/.zsh/functions $fpath)
autoload -U ~/.zsh/functions/*(:t)
source ~/.zsh/functions/_git_prompt

export PS1='${fg[magenta]}%m${fg[white]}:${fg[cyan]}%1~${fg[white]}`git-prompt`${fg[white]}%# '

export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"
