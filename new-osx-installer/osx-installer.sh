#!/bin/bash

set -eu -o pipefail

LOG_PATH="/tmp/osx-installer.log"
ERROR_PATH="/tmp/osx-installer.err"
BREW_ERROR="/tmp/osx-installer-brew.err"
TMP_DIR="/tmp/osx-installer"

PROJECT_DIR="~/dev/src"
DOTFILES="$PROJECT_DIR/github.com/yadunut/dotfiles"

# Brew and Mas apps {{{
BREW_PACKAGES=(
    "bash"
    "bash-completion"
    "clang-format" # C/c++ formatting
    "cloc" # Count lines of code
    "cquery --build-from-source" # C autocompletion engine
    "dos2unix" # Util to convert files with dos line endings to unix
    "duplicity" # Backup utility
    "exiftool" # view file metadata
    "fish" # Fish shell
    "fzf" # Fuzzy finder
    "gcc" # Updated GCC
    "gdb" # Updated GDB
    "git" # Updated git
    "gpg" # GPG tools
    "htop" # Improved top (process viewer)
    "hub" # Adds github features to git
    "hugo" # Blogging engine
    "llvm" # Compiler
    "mas" # App store CLI interface
    "neovim" # Better vim
    "nmap" # network mapping tool
    "node" # Nodejs
    "postgresql" # Postgresql
    "python" # Python3
    "python2"
    "radare2" # GDB but better
    "rsync" # rsync
    "rustup" # Rust
    "sqlmap" # SQL Attack
    "the_silver_searcher" # adds ag, a better find command
    "tmux" # Terminal Multiplexer
    "tree" # Tree view of directories
    "wget" # curl but better
    "youtube-dl" # Youtube downloader
    "zsh" # ZSH shell
)

CASK_PACKAGES=(
    "1password"
    "alfred"
    "bartender"
    "clion"
    "cutter"
    "dash"
    "discord"
    "docker"
    "etcher"
    "exodus"
    "firefox"
    "gitkraken"
    "google-chrome"
    "grammarly"
    "grandperspective"
    "handbrake"
    "hex-fiend"
    "insomnia"
    "java"
    "keybase"
    "mailspring"
    "notion"
    "plex-media-player"
    "rubymine"
    "skype"
    "slack"
    "spectacle"
    "telegram"
    "the-unarchiver"
    "tunnelblick"
    "tuxera-ntfs"
    "visual-studio-code"
    "vlc"
    "vmware-fusion"
    "whatsapp"
    "wireshark"
    "xquartz"
)

MAS_APPS=(
    "1222815823" # Wireless@SG (2.1)
    "407963104" # Pixelmator (3.7.5)
    "409201541" # Pages (7.2)
    "425264550" # Blackmagic Disk Speed Test (3.2)
    "409183694" # Keynote (8.2)
    "585829637" # Todoist (7.1)
    "409203825" # Numbers (5.2)
)
# }}}

# Setup {{{
# Function to clean up code
function finish() {
    exit_value=$?
    echo "Finished Script"
    rm -rf "$TMP_DIR"
    echo "View logs at $LOG_PATH"
    if [[ -s "$ERROR_PATH" ]]; then
        echo "View errors at $ERROR_PATH"
    fi
    echo "Exited with $exit_value"
}

# Always runs when program is exitted
trap finish EXIT

# Ask for xcode installation
while true; do
    read -p "Have you installed XCode? " input
    case $input in
    [yY] | [yY]es)
        break
        ;;

    [nN] | [nN]o)
        echo "Please install XCode and re-run this script"
        exit 1
        ;;
    *)
        echo "Invalid input. Please answer [y]es / [n]o"
        ;;
    esac
done

# Ask for sudo
sudo -v

# Keep-alive: update existing `sudo` time stamp until the script has finished.
while true; do
    sudo -n true
    sleep 60
    kill -0 "$$" || exit
done 2>/dev/null &

# }}}

# Brew and mas installation {{{
if [[ $(command -v brew) ]]; then
    echo "Brew is installed"
else
    echo "Installing brew"
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# List of brew packages with its flags
echo "Installing Brew packages"
for package in "${BREW_PACKAGES[@]}"; do
    if brew install $package; then
        echo "Installed $package"
    else
        echo "Failed to install $package"
        echo "Failed to install $package" >>$ERROR_PATH
    fi
done

for app in "${CASK_PACKAGES[@]}"; do
    if brew cask install $app; then
        echo "Installed $app"
    else
        echo "Failed to install $app"
        echo "Failed to install $app" >>$ERROR_PATH
    fi
done

echo "Launching App Store"
echo "Please login to the app store to install applications from the app store"
sleep 1
osascript -e "tell application \"App Store\" to activate"

while true; do
    read -p "Have you logged in to the app store?" input
    case $input in
    [yY] | [yY]es)
        break
        ;;

    [nN] | [nN]o)
        echo "Please login to continue with the script"
        osascript -e "tell application \"App Store\" to activate"
        exit 1
        ;;
    *)
        echo "Invalid input. Please answer [y]es / [n]o"
        ;;
    esac
done

for app in "${MAS_APPS[@]}"; do
    if mas install "$app"; then
        echo "Installed $app"
    else
        echo "Failed to install $app"
        echo "Failed to install $app" >>$ERROR_PATH
    fi
done

if ! brew doctor; then
    echo "brew doctor failed"
    echo "brew doctor failed" >>$ERROR_PATH
fi

if ! brew cleanup; then
    echo "brew cleanup failed"
    echo "brew cleanup failed" >>$ERROR_PATH
fi

if ! brew prune; then
    echo "brew prune failed"
    echo "brew prune failed" >>$ERROR_PATH
fi

echo "Finished installing apps"
# }}}

# # Clone and symlink repo {{{
mkdir -p $TMP_DIR

git clone --recurse-submodules https://github.com/yadunut/dotfiles $DOTFILES
cd $DOTFILES
git submodule update --remote

ln -s -F $DOTFILES/nvim ~/.config/
ln -s -F $DOTFILES/zshrc.zsh ~/.zshrc
ln -s -F $DOTFILES/tmux.conf ~/.tmux.conf
ln -s -F $DOTFILES/ideavimrc ~/.ideavimrc
ln -s -F $DOTFILES/alacritty.yml ~/.config/alacritty/alacritty.yml

# }}}

# Other Installation {{{
echo "Installing rust"
if [[ $(command -v rustup) ]]; then
    rustup install stable
    rustup component add rustfmt-preview
    rustup component add rls-preview
    rustup component add clippy-preview
else
    echo "Rust not installed"
    echo "Rust not installed" >>$ERROR_PATH
fi

echo "Installing rvm"
gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
\curl -sSL https://get.rvm.io | bash -s stable --ruby
source ~/.rvm/scripts/rvm
rvm install 2.5.1
rvm --default use 2.5.1

echo "Installing inconsolata"
brew tap homebrew/cask-fonts
brew cask install font-inconsolata

git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh >$TMP_DIR/installer.sh
mkdir -p ~/.config/nvim/dein
sh $TMP_DIR/installer.sh ~/.config/nvim/dein

# }}}

# Configurations {{{
git config --global user.name "Yadunand Prem"
git config --global user.email yadunut@gmail.com

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
    killall "${app}" >/dev/null 2>&1
done

# Change shell to zsh
sudo chsh -s /bin/zsh

# }}}

echo "Done"
echo "Remember to run :GoInstallBinaries in vim"

for i in {5..1}; do
    printf "Restarting computer in $i...\\r"
    sleep 1
done
sudo reboot
