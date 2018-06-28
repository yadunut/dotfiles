#System Pref Settings

# Set a faster keyboard repeat rate
defaults write NSGlobalDomain KeyRepeat -int 2
# Set a short delay until repeat
defaults write NSGlobalDomain InitialKeyRepeat -int 20
# require password immediately after sleep or screensaver
defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 0
# Disable Dashboard
defaults write com.apple.dashboard mcx-disabled -bool true
# Automatically hide and show the Dock
defaults write com.apple.dock autohide -bool true
# Change minimize/maximize window effect
defaults write com.apple.dock mineffect -string "genie"

# Bottom right screen corner → Desktop
defaults write com.apple.dock wvous-br-corner -int 4
defaults write com.apple.dock wvous-br-modifier -int 0

# Finder: show status bar
defaults write com.apple.finder ShowStatusBar -bool true

# Finder: show path bar
defaults write com.apple.finder ShowPathbar -bool true

# Show the ~/Library folder
chflags nohidden ~/Library

for app in "Dock" "Finder" "SystemUIServer" "Terminal"; do
	killall "${app}" > /dev/null 2>&1
done

