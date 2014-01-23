## OS X defaults:

sudo scutil --set ComputerName "David Furnes's MacBook Pro"
sudo scutil --set HostName "DFurnes"
sudo scutil --set LocalHostName "DFurnes"

# Make Mission Control animation quicker
defaults write com.apple.dock expose-animation-duration -float 0.25

# Set dock icon size
defaults write com.apple.dock tilesize -int 46

# Expand save panel by default
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true

# Expand print panel by default
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true

# Save to disk (not to iCloud) by default
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false

# Reveal IP address, hostname, OS version, etc. when clicking the clock in the login window
sudo defaults write /Library/Preferences/com.apple.loginwindow AdminHostInfo HostName

# Enable HiDPI display modes (requires restart)
sudo defaults write /Library/Preferences/com.apple.windowserver DisplayResolutionEnabled -bool true

# Set the Finder prefs for showing a few different volumes on the Desktop.
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true
defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool true

# Column view in Finder by default
defaults write com.apple.finder FXPreferredViewStyle -string "clmv"

# When performing a search, search the current folder by default
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

# Finder: hide status bar
defaults write com.apple.finder ShowStatusBar -bool false

# Finder: hide tool bar
defaults write com.apple.finder ShowToolBar -bool false

# Finder: hide side bar
defaults write com.apple.finder ShowSideBar -bool false

# Set up Safari for development.
defaults write com.apple.Safari IncludeInternalDebugMenu -bool true
defaults write com.apple.Safari IncludeDevelopMenu -bool true
defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true
defaults write com.apple.Safari "com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled" -bool true
defaults write NSGlobalDomain WebKitDeveloperExtras -bool true
