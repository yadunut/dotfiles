#ask for sudo
sudo -v

#run sudo constantly
while true; do 
	sudo -n true;
   	sleep 60; 
	kill -0 "$$" || exit; 
done 2>/dev/null &
xcode-select --install

/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

brew doctor
brew doctor

brew update
brew upgrade

brew install archey
brew install cmake
brew install nmap
brew install node
brew install tmux
brew install wget
brew install glew
brew install glfw
brew install glm
brew install tree
#brew install mysql

brew cleanup
brew doctor


#######
#setup vim & terminal
#######
mkdir ~/dev
cd ~/dev

git clone https://github.com/yadunut/dotfiles.git ~/dev/dotfiles

#Clone vundle and set up vim#
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +PluginInstall +qall

ln -s -F ~/dev/dotfiles/.vimrc ~/.vimrc
ln -s -F ~/dev/dotfiles/.bash_profile ~/.bash_profile
ln -s -F ~/dev/dotfiles/.tmux.conf ~/.tmux.conf
ln -s -F ~/dev/dotfiles/.tern-project  ~/.tern-project


################System Prefernces Settings################
#Reboots computer when freeze
systemsetup -setrestartfreeze on

#Sets key repeat rate faster
defaults write NSGlobalDomain KeyRepeat -int 2

#require password immediately after sleep
defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 0

chflags nohidden ~/Library

