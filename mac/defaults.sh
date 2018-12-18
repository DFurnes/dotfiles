# Expand save panel by default
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true

# Set the Finder prefs for showing a few different volumes on the Desktop.
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true
defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool true

# Column view in Finder by default
defaults write com.apple.finder FXPreferredViewStyle -string "clmv"

# When performing a search, search the current folder by default
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

# Finder: show toolbar & sidebar. hide status bar.
defaults write com.apple.finder ShowToolBar -bool true 
defaults write com.apple.finder ShowSideBar -bool true
defaults write com.apple.finder ShowStatusBar -bool false
