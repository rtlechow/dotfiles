export EDITOR=vim

# Vi style command line editing
set -o vi

# Find and set Vim runtime directory
export VIMRUNTIME=`vim -e -T dumb --cmd 'exe "set t_cm=\<C-M>"|echo $VIMRUNTIME|quit' | tr -d '\015' `

# Pretty prompt
export PS1="(\[\033[1;33m\]\!\[\033[0m\] \[\$(prompt_username_color)\]\u\[\033[0m\]@\[\$(prompt_hostname_color)\]\h\[\033[0m\]:\[\033[1;33m\]\w\[\$(prompt_git_branch_color)\]\$(prompt_git_branch)\[\033[1;37m\])\[\033[0;37m\] "

# Larger bash history (default is 500)
export HISTFILESIZE=10000
export HISTSIZE=10000


# Includes user's private bin if it exists
if [ -d ~/bin ] ; then
    PATH=~/bin:"${PATH}"
fi

# Adobe AIR SDK
export PATH=/Users/rtl/Code/airsdk/bin:$PATH

# Shoes
export PATH=/Applications/Shoes.app/Contents/MacOS:$PATH

# MacPorts
export PATH=/opt/local/bin:/opt/local/sbin:$PATH
export MANPATH=/opt/local/share/man:$MANPATH

# System Ruby
export PATH=/System/Library/Frameworks/Ruby.framework/Versions/1.8/usr/bin:$PATH

# Apache
export PATH=/opt/local/apache2/bin:$PATH

# MySQL 64 Bit
export PATH=/usr/local/mysql/bin:$PATH

# RubyGems
export GEM_HOME=$HOME/.gems/ruby/1.8
export GEM_PATH=$GEM_HOME
export PATH=$HOME/.gems/ruby/1.8/bin:$PATH

# Include .bashrc if it exists
if [ -f ~/.bashrc ]; then
    . ~/.bashrc
fi

# rvm-install added:
if [[ -s /Users/rtl/.rvm/scripts/rvm ]] ; then source /Users/rtl/.rvm/scripts/rvm ; fi

