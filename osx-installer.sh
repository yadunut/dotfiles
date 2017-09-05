#ask for sudo
sudo -v

#run sudo constantly
while true; do 
	sudo -n true;
   	sleep 60; 
	kill -0 "$$" || exit; 
done 2>/dev/null &

#Install homebrew
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

#Doctor twice cause brew is dumb sometimes
brew doctor
brew doctor

brew update
brew upgrade

brew install archey
brew install cmake
brew install nmap
brew install node
brew install tmux
brew install neovim
brew install wget
brew install tree
#brew install elixir

#Cleanup
brew cleanup
brew doctor

git clone https://github.com/yadunut/dotfiles.git ~/dev/dotfiles
cd ~/dev/dotfiles

#Links all the appropriate files
ln -s -F ~/dev/dotfiles/bash_profile.bash ~/.bash_profile
ln -s -F ~/dev/dotfiles/git-completion.bash ~/.git-completion.bash
ln -s -F ~/dev/dotfiles/git-completion.zsh ~/.git-completion.zsh
ln -s -F ~/dev/dotfiles/tmux.conf ~/.tmux.conf
ln -s -F ~/dev/dotfiles/vimrc.vim ~/.vimrc
ln -s -F ~/dev/dotfiles/zshrc.zsh ~/.zshrc
ln -s -F ~/dev/dotfiles/nvim.vim ~/.config/nvim/init.vim

#####Vim plugins
#Dein Plugin Manager
curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > installer.sh
chmod +x installer.sh
mkdir -p ~/.config/nvim/dein
sh ./installer.sh ~/.config/nvim/dein










