#!/usr/bin/env bash

# Optimized for performance and minimal animations

# Input Devices

# Trackpad: enable tap to click for this user and for the login screen
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

# Disable natural (Lion-style) scrolling
defaults write NSGlobalDomain com.apple.swipescrolldirection -bool false

# Enable full keyboard access for all controls (e.g. Tab in modal dialogs)
defaults write NSGlobalDomain AppleKeyboardUIMode -int 3

# Performance & Visual Effects

# Reduce transparency for better performance
defaults write com.apple.universalaccess reduceTransparency -bool true

# Reduce motion (disables many system animations)
defaults write com.apple.universalaccess reduceMotion -bool true

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

# Finder

# Show status bar
defaults write com.apple.finder ShowStatusBar -bool true

# Show path bar
defaults write com.apple.finder ShowPathbar -bool true

# Use list view in all Finder windows by default
# Four-letter codes: `icnv` (icon), `clmv` (column), `Flwv` (cover flow), `Nlsv` (list)
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"

# Disable the warning before emptying the Trash
defaults write com.apple.finder WarnOnEmptyTrash -bool false

# Disable all Finder animations
defaults write com.apple.finder DisableAllAnimations -bool true

# Show hidden files by default
defaults write com.apple.finder AppleShowAllFiles -bool true

# Show all filename extensions
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Dock

# Remove all default app icons from the Dock
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

# Disable Dock animations
defaults write com.apple.dock expose-animation-duration -float 0
defaults write com.apple.dock springboard-show-duration -float 0
defaults write com.apple.dock springboard-hide-duration -float 0
defaults write com.apple.dock springboard-page-duration -float 0
defaults write com.apple.dock launchanim -bool false

# Disable app icon bounce animation
defaults write com.apple.dock no-bouncing -bool true

# Minimize windows into application icon
defaults write com.apple.dock minimize-to-application -bool true

# Mission Control & Spaces

# Disable Mission Control animations
defaults write com.apple.dock expose-animation-duration -float 0

# Don't automatically rearrange Spaces based on most recent use
defaults write com.apple.dock mru-spaces -bool false

# Don't show Dashboard as a Space
defaults write com.apple.dock dashboard-in-overlay -bool true

# Mail

# Disable send and reply animations
defaults write com.apple.Mail DisableSendAnimations -bool true
defaults write com.apple.Mail DisableReplyAnimations -bool true

# Screenshots

# Save screenshots to Downloads folder
defaults write com.apple.screencapture location -string "${HOME}/Downloads"

# Save screenshots in PNG format (options: BMP, GIF, JPG, PDF, TIFF)
defaults write com.apple.screencapture type -string "png"

# Disable shadow in screenshots
defaults write com.apple.screencapture disable-shadow -bool true

# Show thumbnail after taking screenshot (useful for quick edits)
defaults write com.apple.screencapture show-thumbnail -bool true

# Photos

# Prevent Photos from opening automatically when devices are plugged in
defaults -currentHost write com.apple.ImageCapture disableHotPlug -bool true

# Browser Settings

# Disable the all too sensitive backswipe on trackpads
defaults write com.google.Chrome AppleEnableSwipeNavigateWithScrolls -bool false
defaults write com.google.Chrome.canary AppleEnableSwipeNavigateWithScrolls -bool false
defaults write com.brave.Browser AppleEnableSwipeNavigateWithScrolls -bool false

# Disable the all too sensitive backswipe on Magic Mouse
defaults write com.google.Chrome AppleEnableMouseSwipeNavigateWithScrolls -bool false
defaults write com.google.Chrome.canary AppleEnableMouseSwipeNavigateWithScrolls -bool false
defaults write com.brave.Browser AppleEnableMouseSwipeNavigateWithScrolls -bool false

# File Associations (using duti)

if ! command -v duti &> /dev/null; then
  echo "duti not found. Install with: brew install duti"
  echo "Skipping file associations..."
else
  echo "Setting file associations..."

  # Video files -> VLC
  for ext in avi mkv mp4 m4v mov wmv flv webm mpg mpeg m2v 3gp ogv; do
    duti -s org.videolan.vlc ".${ext}" all
  done

  # Audio files -> VLC
  for ext in mp3 m4a flac wav aac ogg opus wma; do
    duti -s org.videolan.vlc ".${ext}" all
  done

  # Archive files -> The Unarchiver
  for ext in zip rar 7z tar gz bz2 xz tgz tbz; do
    duti -s com.macpaw.site.theunarchiver ".${ext}" all
  done
  duti -s com.macpaw.site.theunarchiver .tar.gz all
  duti -s com.macpaw.site.theunarchiver .tar.bz2 all
  duti -s com.macpaw.site.theunarchiver .tar.xz all

  # HTTP/HTTPS -> Brave Nightly
  duti -s com.brave.Browser.nightly http all
  duti -s com.brave.Browser.nightly https all

  # Markdown files -> Obsidian
  duti -s md.obsidian .md all

  echo "File associations set."
fi

# Additional Performance Optimizations

# Disable automatic termination of inactive apps
defaults write NSGlobalDomain NSDisableAutomaticTermination -bool true

# Speed up wake from sleep
sudo pmset -a standbydelay 86400

# Disable sudden motion sensor (not needed for SSDs)
sudo pmset -a sms 0

# Restart affected applications

echo ""
echo "Done. Some changes require a logout/restart to take effect."
echo "Restarting affected apps..."

for app in "Dock" "Finder" "Mail" "SystemUIServer"; do
  killall "${app}" &> /dev/null
done

echo "Complete!"
