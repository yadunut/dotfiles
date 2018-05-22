#!/bin/sh

#__   __        _                             _   ______
#\ \ / /       | |                           | |  | ___ \
# \ V /__ _  __| |_   _ _ __   __ _ _ __   __| |  | |_/ / __ ___ _ __ ___
#  \ // _` |/ _` | | | | '_ \ / _` | '_ \ / _` |  |  __/ '__/ _ \ '_ ` _ \
#  | | (_| | (_| | |_| | | | | (_| | | | | (_| |  | |  | | |  __/ | | | | |
#  \_/\__,_|\__,_|\__,_|_| |_|\__,_|_| |_|\__,_|  \_|  |_|  \___|_| |_| |_|

################################################################################
################ osx installer script to setup new computers ###################
################################################################################

# Ask for sudo
sudo -v

#Keep Sudo Alive
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

#Install Xcode CLI
xcode-select --install


################################### Homebrew ###################################

#Install Homebrew(Package Manager for Mac)
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

#Brew doctor cleans up if theres issues(Run it twice cause issues)
brew doctor
brew doctor

#Update and Upgrade brew
brew update
brew upgrade
brew doctor

#Terminal Multiplexer
brew install tmux
#Better Vim
brew install neovim
#Similar to curl
brew install wget
#Visual ls
brew install tree
#Golang
brew install go
#Python
brew install python
brew install python3
#zsh
brew install zsh

#Doctor and cleanup to delete un-necessary files
brew cleanup
brew doctor

#Get Homebrew casks to install applications
brew tap caskroom/cask
#VSCode
brew cask install visual-studio-code
#Firefox
brew cask install firefox
#Discord
brew cask install discord
#Google Chrome
brew cask install google-chrome
#1Password
brew cask install 1password
#Whatsapp
brew cask install whatsapp
#Alfred
brew cask install alfred
#Bartender Menu Bar
brew cask install bartender
#Git Kraken
brew cask install gitkraken
#The Unarchiver
brew cask install the-unarchiver
#VLC
brew cask install vlc
#Tuxera NTFS
brew cask install tuxera-ntfs

#Python support for neovim
pip3 install neovim


#Clone my dotfiles into the proper directory
git clone https://github.com/yadunut/dotfiles.git ~/dev/dotfiles

#Clone Tmux Plugin Manager into Proper directory
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# Install oh my zsh
export ZSH="$HOME/dev/dotfiles/oh-my-zsh"; sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

#Install Inconsolata for powerline
wget -P ~/Library/Fonts https://github.com/powerline/fonts/raw/master/Inconsolata/Inconsolata%20for%20Powerline.otf

#Make files directory to store files
mkdir -p ~/dev/dotfiles/files
mkdir -p ~/.config/nvim/dein

#Install Dein(Plugin Manager for vim)
curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > ~/dev/dotfiles/files/installer.sh
sh ~/dev/dotfiles/files/installer.sh ~/.config/nvim/dein

#Setup for deoplete-go
go get -u github.com/nsf/gocode

#symlink the appropriate files in the dotfiles folder
ln -s -F ~/dev/dotfiles/nvim.vim  ~/.config/nvim/init.vim
ln -s -F ~/dev/dotfiles/zshrc.zsh ~/.zshrc
ln -s -F ~/dev/dotfiles/tmux.conf ~/.tmux.conf


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


#Messages for the user
echo "Remember to set terminal font to Inconsolata for Powerline"
echo "Install Terminal Color Schemes and set default to solarized dark"
