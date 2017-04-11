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
#brew install glew
#brew install glfw
#brew install glm
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

ln -s -F ~/dev/dotfiles/.vimrc ~/.vimrc
ln -s -F ~/dev/dotfiles/.bash_profile ~/.bash_profile
ln -s -F ~/dev/dotfiles/.tmux.conf ~/.tmux.conf
ln -s -F ~/dev/dotfiles/.tern-project  ~/.tern-project

chflags nohidden ~/Library
