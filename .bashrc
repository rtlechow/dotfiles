# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# Store duplicate commands in history and append all histories, so I can identify and refactor frequently used commands
# export HISTCONTROL=ignoredups
shopt -s histappend

# Check the window size after each command and, if necessary, update the values of LINES and COLUMNS
shopt -s checkwinsize

# Make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(lesspipe)"

# Alias definitions.
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# Include .bash_private if it exists
if [ -f ~/.bash_private ]; then
    . ~/.bash_private
fi

# Colorize ls by default
if [ "$TERM" != "dumb" ]; then
    export LS_OPTIONS='--color=auto'
    eval `dircolors ~/.dir_colors`
    export GREP_OPTIONS='--color=auto'
    export GREP_COLOR='1;32'
fi

# Enable programmable completion features (you don't need to enable this, if it's already enabled in /etc/bash.bashrc and /etc/profile sources /etc/bash.bashrc)
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi
if [ -f /opt/local/etc/bash_completion ]; then
    . /opt/local/etc/bash_completion
fi

# Enable git completion and __git_ps1
if [ -f ~/.git-completion.sh ]; then
  . ~/.git-completion.sh
fi

# Pretty prompt functions
prompt_username_color() {
  if [ "$(id -u)" == "0" ]; then
    echo -e "\033[1;31m"
  else
    echo -e "\033[1;32m"
  fi
}

prompt_hostname_color() {
  if [[ ${SSH_CLIENT} ]] || [[ ${SSH2_CLIENT} ]]; then 
    echo -e "\033[1;35m"
  else
    echo -e "\033[1;32m"
  fi
}

prompt_git_branch_color() {
  if type -p __git_ps1; then
    branch=$(__git_ps1 '%s')
    if [ -n "$branch" ]; then
      status=$(git status 2> /dev/null)

      if $(echo $status | grep 'added to commit' &> /dev/null); then
      # If we have modified files but no index (blue)
        echo -e "\033[1;34m"
      else
        if $(echo $status | grep 'to be committed' &> /dev/null); then
        # If we have files in index (red)
          echo -e "\033[1;31m"
        else
        # If we are completely clean (green)
          echo -e "\033[1;32m"
        fi
      fi
    fi
  fi
}

prompt_git_branch() {
  if type -p __git_ps1; then
    branch=$(__git_ps1 '%s')
    if [ -n "$branch" ]; then
      echo -e " $branch"
    fi
  fi
}
