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
brew install tmux --with-utf8proc
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
DOTFILES = ~/dev/src/github.com/yadunut/dotfiles
git clone https://github.com/yadunut/dotfiles.git $DOTFILES

#Clone Tmux Plugin Manager into Proper directory
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# Install oh my zsh
git clone https://github.com/robbyrussell/oh-my-zsh.git $DOTFILES/oh-my-zsh
cp ~/.zshrc ~/.zshrc.orig

#Install Inconsolata for powerline
wget ~/Library/Fonts https://github.com/powerline/fonts/raw/master/Inconsolata/Inconsolata%20for%20Powerline.otf
wget ~/Library/Fonts https://github.com/google/fonts/raw/master/ofl/inconsolata/Inconsolata-Bold.ttf
wget  ~/Library/Fonts https://github.com/google/fonts/raw/master/ofl/inconsolata/Inconsolata-Regular.ttf

#Make files directory to store files
mkdir -p $DOTFILES/files
mkdir -p ~/.config/nvim/dein

#Install Dein(Plugin Manager for vim)
curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > $DOTFILES/files/installer.sh
sh $DOTFILES/files/installer.sh ~/.config/nvim/dein


#Setup for deoplete-go
go get -u github.com/nsf/gocode

#symlink the appropriate files in the dotfiles folder
sh $DOTFILES/osx-installer/link.sh

#Messages for the user
echo "Remember to set terminal font to Inconsolata for Powerline"
echo "Install Terminal Color Schemes and set default to solarized dark"
