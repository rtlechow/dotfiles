export EDITOR=vim

# Vi style command line editing
set -o vi

# MacPorts, Shoes
export PATH=~/Code/airsdk/bin:/opt/local/bin:/opt/local/sbin:/Applications/Shoes.app/Contents/MacOS:$PATH
export MANPATH=/opt/local/share/man:$MANPATH

# Pretty prompt
export PS1="(\[\033[1;33m\]\!\[\033[0m\] \[\$(prompt_username_color)\]\u\[\033[0m\]@\[\$(prompt_hostname_color)\]\h\[\033[0m\]:\[\033[1;33m\]\w\[\$(prompt_git_branch_color)\]\$(prompt_git_branch)\[\033[1;37m\])\[\033[0m\] "

# Include .bashrc if it exists
if [ -f ~/.bashrc ]; then
    . ~/.bashrc
fi

# Includes user's private bin if it exists
if [ -d ~/bin ] ; then
    PATH=~/bin:"${PATH}"
fi

# Larger bash history (default is 500)
export HISTFILESIZE=10000
export HISTSIZE=10000
