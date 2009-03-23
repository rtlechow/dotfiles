export EDITOR=vim

# Vi style command line editing
set -o vi

# MacPorts
export PATH=/opt/local/bin:/opt/local/sbin:$PATH
export MANPATH=/opt/local/share/man:$MANPATH

# Terminal colours (after installing GNU coreutils)
NM="\[\033[1;37m\]" #means no background and white lines
HI="\[\033[0;37m\]" #change this for letter colors
HII="\[\033[1;32m\]" #change this for letter colors
SI="\[\033[1;33m\]" #this is for the current directory
IN="\[\033[0m\]"
 
# Pretty prompt that shows current git branch, if one exists
export PS1="$NM($HII\u$NM@$HII\h$NM:$SI\w \`git branch 2> /dev/null | grep -e ^* | sed -E  s/^\\\\\\\\\*\ \(.+\)$/\(\\\\\\\\\1\)\/\`\[\033[37m\]\[\033[00m\]$NM) $IN"

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
