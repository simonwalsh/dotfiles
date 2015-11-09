#!/bin/bash

# Run ./osx-set-defaults.sh and you'll be good to go.
# See: github.com/mathiasbynens/dotfiles


# General UI/UX
# ----------------------------------------------------------------------

# Enable snap-to-grid for desktop icons
/usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist

# Save to disk (not to iCloud) by default
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false

# Automatically quit printer app once the print jobs complete
defaults write com.apple.print.PrintingPrefs "Quit When Finished" -bool true

# Don’t automatically rearrange Spaces based on most recent use
defaults write com.apple.dock mru-spaces -bool false

# Set a really fast key repeat.
defaults write NSGlobalDomain KeyRepeat -int 0

# Disable the "accent menu" so key repeat works as expected...
defaults write -g ApplePressAndHoldEnabled -bool false

# Disable Resume system-wide
defaults write NSGlobalDomain NSQuitAlwaysKeepsWindows -bool false

# Reveal IP address, hostname, OS version, etc. when clicking the clock in the login window
sudo defaults write /Library/Preferences/com.apple.loginwindow AdminHostInfo HostName

# Disable Notification Center and remove the menu bar icon
# launchctl unload -w /System/Library/LaunchAgents/com.apple.notificationcenterui.plist


# Dock
# ----------------------------------------------------------------------

# Faster Dock animation
defaults write com.apple.dock autohide-time-modifier -float 0.5;killall Dock

# Dock: show indicator lights for open applications
defaults write com.apple.dock show-process-indicators -bool true


# Finder
# ----------------------------------------------------------------------

# Always open everything in Finder's Column view. This is important.
defaults write com.apple.finder FXPreferredViewStyle -string "Clmv"

# Show the ~/Library folder.
chflags nohidden ~/Library

# Set the Finder prefs for showing a few different volumes on the Desktop.
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true
defaults write com.apple.finder ShowMountedServersOnDesktop -bool true
defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool true

# Finder: show all filename extensions
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Finder: show status bar
defaults write com.apple.finder ShowStatusBar -bool true

# Finder: disable the warning when changing a file extension
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

# Finder: disable window and Get Info animations
defaults write com.apple.finder DisableAllAnimations -bool true


# Panels
# ----------------------------------------------------------------------

# Expand save panel by default
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true

# Panels: expand print panel by default
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true


# Screen
# ----------------------------------------------------------------------

# Screen: require password immediately after sleep or screen saver begins
defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 0

# Screen: save screenshots to the desktop
defaults write com.apple.screencapture location -string "$HOME/Desktop"

# Screen: enable subpixel font rendering on non-Apple LCDs
defaults write NSGlobalDomain AppleFontSmoothing -int 2


# Disks
# ----------------------------------------------------------------------

# Disks: avoid creating .DS_Store files on network volumes
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true

# Disks: disable Time Machine prompts
defaults write com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool true

# Misc
# ----------------------------------------------------------------------
#

# Misc: only use UTF-8 in Terminal.app
defaults write com.apple.terminal StringEncodings -array 4

# Misc: disable Dictionary results
defaults write com.apple.spotlight DictionaryLookupEnabled -bool false

# Misc: disable auto-correct
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false

# Use AirDrop over every interface. srsly this should be a default.
defaults write com.apple.NetworkBrowser BrowseAllInterfaces 1

# Check for software updates daily, not just once per week
defaults write com.apple.SoftwareUpdate ScheduleFrequency -int 1

# Enable Quicklook text selection
defaults write com.apple.finder QLEnableTextSelection -bool TRUE

for app in "Dashboard" "Dock" "Finder" "SystemUIServer" "Terminal"; do
  killall "$app" > /dev/null 2>&1
done
