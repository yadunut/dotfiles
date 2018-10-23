DOTFILES=~/dev/src/github.com/yadunut/dotfiles

ln -s -F ~/dev/src/github.com/yadunut/dotfiles/nvim ~/.config/
ln -s -F $DOTFILES/zshrc.zsh ~/.zshrc
ln -s -F $DOTFILES/tmux.conf ~/.tmux.conf
ln -s -F $DOTFILES/ideavimrc ~/.ideavimrc
ln -s -F $DOTFILES/scripts/backup.sh /usr/local/bin/backup
ln -s -F ~/dev/src/github.com/yadunut/ekko/ekko.rb /usr/local/bin/ekko
