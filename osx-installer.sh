################################################################################
########### Yadunand's osx installer script to setup new computers #############
################################################################################

# Ask for sudo
sudo -v


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

#Clone my dotfiles into the proper directory
git clone https://github.com/yadunut/dotfiles.git ~/dev/dotfiles

# Install oh my zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

#Install Inconsolata for powerline
wget -P ~/Library/Fonts https://github.com/powerline/fonts/raw/master/Inconsolata/Inconsolata%20for%20Powerline.otf

#Make files directory to store files
mkdir -p ~/dev/dotfiles/files
mkdir -p ~/.config/nvim/dein

#Install Dein(Plugin Manager for vim)
curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > ~/dev/dotfiles/files/installer.sh
sh ~/dev/dotfiles/files/installer.sh ~/.config/nvim/dein


#symlink the appropriate files in the dotfiles folder
ln -s -F ~/dev/dotfiles/nvim.vim ~/.config/nvim/init.vim
ln -s -F ~/dev/dotfiles/zshrc.zsh   ~/.zshrc

#Messages for the user
echo "Remember to set terminal font to Inconsolata for Powerline"
echo "Install Terminal Color Schemes and set default to solarized dark"
