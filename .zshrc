export KEYTIMEOUT=1
export EDITOR='vim'
export LESS='-RFX'
export PAGER='less'
export JAVA_HOME='/Library/Java/Home'
export GREP_COLOR='0;32'
export RIPGREP_CONFIG_PATH="$HOME/.ripgreprc"
export GOPATH=$HOME/go

shdir=~/.zsh
configs=(
  options.zsh
  aliases.zsh
  ../.localrc
)
for f in $configs; do
  [[ -f $shdir/$f ]] && . $shdir/$f
done

zstyle ':completion:*:cd:*' ignore-parents parent pwd # cd will never select the parent directory (e.g.: cd ../<TAB>)
zstyle ':completion:*' completer _expand _complete

if type brew &>/dev/null; then
  FPATH=$(brew --prefix)/share/zsh-completions:$FPATH
fi
fpath=(/opt/homebrew/share/zsh/site-functions /usr/local/share/zsh/site-functions $fpath)
autoload -Uz compaudit compinit && compinit
autoload -Uz colors && colors

[[ -f ~/.dir_colors ]] && eval "$(dircolors ~/.dir_colors)"

fpath=(~/.zsh/functions $fpath)
autoload -U ~/.zsh/functions/*(:t)
[[ -f ~/.zsh/functions/_git_prompt ]] && source ~/.zsh/functions/_git_prompt

# Git completion for custom functions
_gch() {
  local curcontext="$curcontext" state line
  typeset -A opt_args

  _arguments -C \
    '*::branch:->branch'

  case $state in
    branch)
      local -a branches
      branches=(${(f)"$(git branch --format='%(refname:short)' 2>/dev/null)"})
      _describe 'branch' branches
      ;;
  esac
}
compdef _gch gch

# Load zsh plugins
[[ -f ~/.zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh ]] && source ~/.zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
[[ -f ~/.zsh/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh ]] && source ~/.zsh/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh

export PS1='%{$fg[magenta]%}%m%{$fg[white]%}:%{$fg[cyan]%}%1~%{$fg[white]%}$(git-prompt)%{$fg[white]%}%# '

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

autoload -U edit-command-line
zle -N edit-command-line
bindkey '^x^x' edit-command-line

[[ -f "$HOME/.local/bin/env" ]] && . "$HOME/.local/bin/env"

# Initialize zoxide (smart cd with frecency-based directory jumping)
command -v zoxide >/dev/null 2>&1 && eval "$(zoxide init zsh)"
command -v zoxide >/dev/null 2>&1 && alias cd='z'

command -v mise >/dev/null 2>&1 && eval "$(/opt/homebrew/bin/mise activate zsh)"
