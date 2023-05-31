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

zstyle ':completion:*:cd:*' ignore-parents parent pwd # cd will never select the parent directory (e.g.: cd ../<TAB>)
zstyle ':completion:*' completer _expand _complete

autoload -Uz compaudit compinit && compinit
autoload -Uz colors && colors

eval `dircolors ~/.dir_colors`

fpath=(~/.zsh/functions $fpath)
autoload -U ~/.zsh/functions/*(:t)
source ~/.zsh/functions/_git_prompt

export PS1='%{$fg[magenta]%}%m%{$fg[white]%}:%{$fg[cyan]%}%1~%{$fg[white]%}`git-prompt`%{$fg[white]%}%# '

function zle-keymap-select() {
  zle reset-prompt
  zle -R
}

zle -N zle-keymap-select

function vi_mode_prompt_info() {
  echo "${${KEYMAP/vicmd/[% NORMAL]%}/(main|viins)/}"
}

# define right prompt, regardless of whether the theme defined it
RPS1='$(vi_mode_prompt_info)'
RPS2=$RPS1

eval "$(rbenv init - --no-rehash)"

export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm

autoload -U edit-command-line
zle -N edit-command-line
bindkey '^x^x' edit-command-line
