#!/usr/bin/env bash

# TODO:
# remap capslock to control
# show volume in menubar
# iterm config (disable native fullscreen, 24pt)

# change shell
sudo sh -c "echo '/bin/zsh' >> /etc/shells"
chsh -s /bin/zsh

# Trackpad: enable tap to click for this user and for the login screen
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

# Disable natural (Lion-style) scrolling
defaults write NSGlobalDomain com.apple.swipescrolldirection -bool false

# Enable full keyboard access for all controls
# (e.g. enable Tab in modal dialogs)
defaults write NSGlobalDomain AppleKeyboardUIMode -int 3

# Finder: show status bar
defaults write com.apple.finder ShowStatusBar -bool true

# Finder: show path bar
defaults write com.apple.finder ShowPathbar -bool true

# Display full POSIX path as Finder window title
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true

# Use list view in all Finder windows by default
# Four-letter codes for the other view modes: `icnv`, `clmv`, `Flwv`
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"

# Disable the warning before emptying the Trash
defaults write com.apple.finder WarnOnEmptyTrash -bool false

# Wipe all (default) app icons from the Dock
# This is only really useful when setting up a new Mac, or if you don’t use
# the Dock to launch apps.
defaults write com.apple.dock persistent-apps -array

# Show only open applications in the Dock
defaults write com.apple.dock static-only -bool true

# Remove the auto-hiding Dock delay
defaults write com.apple.dock autohide-delay -float 0
# Remove the animation when hiding/showing the Dock
defaults write com.apple.dock autohide-time-modifier -float 0

# Automatically hide and show the Dock
defaults write com.apple.dock autohide -bool true

# Position Dock on left side (maximizes vertical screen space)
defaults write com.apple.dock orientation left

###############################################################################
# Disable Animations - Makes macOS feel instant and snappy                    #
###############################################################################

# Disable window animations and Get Info animations
defaults write NSGlobalDomain NSAutomaticWindowAnimationsEnabled -bool false

# Disable smooth scrolling
defaults write NSGlobalDomain NSScrollAnimationEnabled -bool false

# Disable window resize animations
defaults write NSGlobalDomain NSWindowResizeTime -float 0.001

# Disable Quick Look animations
defaults write NSGlobalDomain QLPanelAnimationDuration -float 0

# Disable rubber band scrolling (bounce at edges)
defaults write NSGlobalDomain NSScrollViewRubberbanding -bool false

# Disable document version animations
defaults write NSGlobalDomain NSDocumentRevisionsWindowTransformAnimation -bool false

# Disable fullscreen toolbar animation
defaults write NSGlobalDomain NSToolbarFullScreenAnimationDuration -int 0

# Disable column animation in Finder
defaults write NSGlobalDomain NSBrowserColumnAnimationSpeedMultiplier -float 0

# Additional Dock animation settings
defaults write com.apple.dock expose-animation-duration -float 0
defaults write com.apple.dock springboard-show-duration -float 0
defaults write com.apple.dock springboard-hide-duration -float 0
defaults write com.apple.dock springboard-page-duration -float 0
defaults write com.apple.dock launchanim -bool false

# Disable all Finder animations
defaults write com.apple.finder DisableAllAnimations -bool true

# Disable Mail animations
defaults write com.apple.Mail DisableSendAnimations -bool true
defaults write com.apple.Mail DisableReplyAnimations -bool true

###############################################################################
# Screenshots                                                                 #
###############################################################################

# Save screenshots to Downloads folder instead of Desktop
defaults write com.apple.screencapture location -string "${HOME}/Downloads"

# Save screenshots in PNG format (other options: BMP, GIF, JPG, PDF, TIFF)
defaults write com.apple.screencapture type -string "png"

# Disable shadow in screenshots
defaults write com.apple.screencapture disable-shadow -bool true

###############################################################################
# Software Updates                                                            #
###############################################################################

# Enable the automatic update check
defaults write com.apple.SoftwareUpdate AutomaticCheckEnabled -bool true

# Check for software updates daily, not just once per week
defaults write com.apple.SoftwareUpdate ScheduleFrequency -int 1

# Download newly available updates in background
defaults write com.apple.SoftwareUpdate AutomaticDownload -int 1

# Install System data files & security updates
defaults write com.apple.SoftwareUpdate CriticalUpdateInstall -int 1

# Turn on app auto-update
defaults write com.apple.commerce AutoUpdate -bool true

# Prevent Photos from opening automatically when devices are plugged in
defaults -currentHost write com.apple.ImageCapture disableHotPlug -bool true


###############################################################################
# Browser Settings                                                            #
###############################################################################

# Disable the all too sensitive backswipe on trackpads
defaults write com.google.Chrome AppleEnableSwipeNavigateWithScrolls -bool false
defaults write com.google.Chrome.canary AppleEnableSwipeNavigateWithScrolls -bool false
defaults write com.brave.Browser AppleEnableSwipeNavigateWithScrolls -bool false

# Disable the all too sensitive backswipe on Magic Mouse
defaults write com.google.Chrome AppleEnableMouseSwipeNavigateWithScrolls -bool false
defaults write com.google.Chrome.canary AppleEnableMouseSwipeNavigateWithScrolls -bool false
defaults write com.brave.Browser AppleEnableMouseSwipeNavigateWithScrolls -bool false

###############################################################################
# File Associations (using duti)                                              #
###############################################################################

# Install duti if not present
if ! command -v duti &> /dev/null; then
  echo "duti not found. Install with: brew install duti"
  echo "Skipping file associations..."
else
  echo "Setting file associations..."

  duti -s org.videolan.vlc .avi all
  duti -s org.videolan.vlc .mkv all
  duti -s org.videolan.vlc .mp4 all
  duti -s org.videolan.vlc .m4v all
  duti -s org.videolan.vlc .mov all
  duti -s org.videolan.vlc .wmv all
  duti -s org.videolan.vlc .flv all
  duti -s org.videolan.vlc .webm all
  duti -s org.videolan.vlc .mpg all
  duti -s org.videolan.vlc .mpeg all
  duti -s org.videolan.vlc .m2v all
  duti -s org.videolan.vlc .3gp all
  duti -s org.videolan.vlc .ogv all

  duti -s org.videolan.vlc .mp3 all
  duti -s org.videolan.vlc .m4a all
  duti -s org.videolan.vlc .flac all
  duti -s org.videolan.vlc .wav all
  duti -s org.videolan.vlc .aac all
  duti -s org.videolan.vlc .ogg all
  duti -s org.videolan.vlc .opus all
  duti -s org.videolan.vlc .wma all

  duti -s com.macpaw.site.theunarchiver .zip all
  duti -s com.macpaw.site.theunarchiver .rar all
  duti -s com.macpaw.site.theunarchiver .7z all
  duti -s com.macpaw.site.theunarchiver .tar all
  duti -s com.macpaw.site.theunarchiver .gz all
  duti -s com.macpaw.site.theunarchiver .bz2 all
  duti -s com.macpaw.site.theunarchiver .xz all
  duti -s com.macpaw.site.theunarchiver .tar.gz all
  duti -s com.macpaw.site.theunarchiver .tgz all
  duti -s com.macpaw.site.theunarchiver .tar.bz2 all
  duti -s com.macpaw.site.theunarchiver .tbz all
  duti -s com.macpaw.site.theunarchiver .tar.xz all

  duti -s com.brave.Browser.nightly http all
  duti -s com.brave.Browser.nightly https all

  duti -s md.obsidian .md all

  echo "File associations set."
fi

###############################################################################
# Kill affected applications                                                  #
###############################################################################

echo "Done. Note that some of these changes require a logout/restart to take effect."
echo "Restarting affected apps..."

for app in "Dock" "Finder" "Mail" "SystemUIServer"; do
  killall "${app}" &> /dev/null
done
