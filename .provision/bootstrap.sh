# Install Homebrew (also installs Command Line Tools for Xcode, which takes a minute)
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Add Homebrew to PATH
(echo; echo 'eval "$(/opt/homebrew/bin/brew shellenv)"') >> /Users/rtl/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv)"

# dotfiles need hub, provisioning needs ansible
brew install hub ansible

# Install dotfiles
git init .
git remote add origin https://github.com/rtlechow/dotfiles.git
git pull origin master

# Vim plugins
git submodule update --init --recursive

# Ansible asks for sudoer password at the start, and before installing vagrant (just after the-unarchiver)
provision
