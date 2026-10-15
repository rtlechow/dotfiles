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

# Catppuccin Frappé colors for ls/eza/completion via vivid
if (( $+commands[vivid] )); then
  export LS_COLORS="$(vivid generate catppuccin-frappe)"
elif [[ -f ~/.dir_colors ]]; then
  eval "$(dircolors ~/.dir_colors)"
fi

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

_git_bdf() {
  local -A worktree_paths
  local -a with_worktree without_worktree
  local line wt branch head

  git rev-parse --git-dir >/dev/null 2>&1 || return 1

  while IFS= read -r line; do
    case $line in
      'worktree '*) wt=${line#worktree } ;;
      'branch refs/heads/'*) worktree_paths[${line#branch refs/heads/}]=${wt/#$HOME/\~} ;;
    esac
  done < <(git worktree list --porcelain 2>/dev/null)

  head=$(git symbolic-ref --short HEAD 2>/dev/null)

  for branch in ${(f)"$(git for-each-ref --format='%(refname:short)' refs/heads 2>/dev/null)"}; do
    [[ $branch == $head ]] && continue
    if [[ -n ${worktree_paths[$branch]} ]]; then
      with_worktree+=("${branch}:${worktree_paths[$branch]}")
    else
      without_worktree+=("${branch}:no worktree")
    fi
  done

  _describe -t worktree-branches 'branch with worktree' with_worktree
  _describe -t branches 'branch' without_worktree
}
compdef _git_bdf git-force-delete-branch git-bdf

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

if [[ -o interactive ]]; then
  # Initialize zoxide (smart cd with frecency-based directory jumping)
  command -v zoxide >/dev/null 2>&1 && eval "$(zoxide init zsh)"
  command -v zoxide >/dev/null 2>&1 && alias cd='z'
fi

command -v mise >/dev/null 2>&1 && eval "$(/opt/homebrew/bin/mise activate zsh)"
# age identity for fnox's local sync cache (avoids 1Password/Touch ID prompts)
export FNOX_AGE_KEY_FILE="$HOME/.ssh/id_ed25519"
command -v fnox >/dev/null 2>&1 && eval "$(fnox activate zsh)"

# Codex CLI: auto-approve through automatic review (--approve-for-me replaced --full-auto)
codex() { command codex --approve-for-me "$@"; }

# kubectx / kubens short aliases (fzf interactive if no arg given)
alias kctx=kubectx
alias kns=kubens

# Added by LM Studio CLI (lms)
export PATH="$PATH:/Users/rtl/.cache/lm-studio/bin"
# End of LM Studio CLI section

# The following lines have been added by Docker Desktop to enable Docker CLI completions.
fpath=(/Users/rtl/.docker/completions $fpath)
autoload -Uz compinit
compinit
# End of Docker CLI completions
