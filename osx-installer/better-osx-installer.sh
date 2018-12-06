#!/bin/bash

set -eu -o pipefail

LOG_PATH="/tmp/osx-installer.log"
TMP_DIR="/tmp/osx-installer"

PROJECT_DIR="$HOME/dev/src"
DOTFILES="$PROJECT_DIR/github.com/yadunut/dotfiles"

# Clean up tmp dir on exit {{{
function finish() {
    echo "Finished"
}

trap finish EXIT
# }}}

# Util functions {{{
# display notifications {{{
function display_notification() {
    log "$1"
    osascript -e "display notification \"$1\" with title \"Backup\""
}
# }}}

# Print usage{{{
function print_usage() {
    echo "Usage: $0 [-a | --all ] [-h | --help] [-b | --brew] [-s | --symlink]"
    echo "    -a | --all:       run full script"
    echo "    -b | --brew:      Install brew and brew deps"
    echo "    -a | --symlink:   Symlink files from dotfiles to HOME and .config"
    echo "    -h | --help:      show this help page"
}
# }}}

# Print error message {{{
function print_error() {
    echo "Command line error: Expected 1 args, got 0"
    echo "Enter '$0 --help' for help screen"
}
# }}}

# Log {{{
function log() {
    echo "$1" 2>&1 | tee "$LOG_PATH"
}
# }}}
# }}}

# Clones dotfiles {{{
function clone_dotfiles() {
    git clone --recurse-submodules https://github.com/yadunut/dotfiles "$DOTFILES"
    cd "$DOTFILES"
    git submodule update --remote
}
# }}}

# Symlink files to repo {{{
function symlink_repo() {
    mkdir -p "$HOME/.config/alacritty"

    ln -s -F "$DOTFILES/nvim" "$HOME/.config/"
    ln -s -F "$DOTFILES/zshrc.zsh" "$HOME/.zshrc"
    ln -s -F "$DOTFILES/tmux.conf" "$HOME/.tmux.conf"
    ln -s -F "$DOTFILES/ideavimrc" "$HOME/.ideavimrc"
    ln -s -F "$DOTFILES/alacritty.yml" "$HOME/.config/alacritty/alacritty.yml"
}
# }}}

# Install brew and deps {{{
function install_brew() {
    if command -v brew &>"$LOG_PATH"; then
        log "Brew is installed"
    else
        log "Installing brew"
        /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    fi

    if brew bundle check &>"$LOG_PATH"; then
        log "brew deps all installed"
    else
        log "Installing brew deps"
        if brew bundle --file="$DOTFILES/Brewfile" 2>&1 | tee "$LOG_PATH"; then
            log "Successfully installed all deps"
        else
            log "Failed to install deps. Check $LOG_PATH for more details"
        fi
    fi
}
# }}}

# Rust {{{
function install_rust() {
    if command -v rustup &>"$LOG_PATH"; then
        rustup install stable
        rustup component add rustfmt-preview
        rustup component add rls-preview
        rustup component add clippy-preview
    else
        echo "Rust not installed"
        echo "Rust not installed" >>"$LOG_PATH"
    fi
}
# }}}

# Install rvm {{{
function install_rvm() {
    log "Installing rvm"
    gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
    \curl -sSL https://get.rvm.io | bash -s stable --ruby
    # shellcheck source=/dev/null
    source "$HOME/.rvm/scripts/rvm"
    rvm install 2.5.1
    rvm --default use 2.5.1
}
# }}}

# Install TPM {{{
function install_tpm() {
    git clone https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"
}
# }}}

# Install dein(VIM) # {{{
function install_dein() {
    mkdir -p "$TMP_DIR"
    curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh >$TMP_DIR/installer.sh
    mkdir -p "$HOME/.config/nvim/dein"
    sh "$TMP_DIR/installer.sh" "$HOME/.config/nvim/dein"
}
# }}}

# Install ZSH prompt {{{
function install_git_prompt() {
    git clone https://github.com/olivierverdier/zsh-git-prompt.git "$DOTFILES"
    cd "$DOTFILES/zsh-git-prompt"
    stack setup
    stack build && stack install
}
# }}}

# Setup git {{{
function setup_git() {
    git config --global user.name "Yadunand Prem"
    git config --global user.email yadunut@gmail.com
}
# }}}

# Setup system prefs {{{
function setup_system_prefs() {
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
    chflags nohidden "$HOME/Library"

    for app in "Dock" "Finder" "SystemUIServer" "Terminal"; do
        killall "${app}" >/dev/null 2>&1
    done
}
# }}}

# run full script {{{
function all() {
    # Ask for xcode installation {{{
    while true; do
        read -r -p "Have you installed XCode? " input
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
    # }}}

    # Ask for sudo {{{
    sudo -v

    # Keep-alive: update existing `sudo` time stamp until the script has finished.
    while true; do
        sudo -n true
        sleep 60
        kill -0 "$$" || exit
    done 2>/dev/null &
    # }}}

    clone_dotfiles
    symlink_repo
    install_brew
    install_rust
    install_rvm
    install_tpm
    install_dein
    install_git_prompt
    setup_git
    setup_system_prefs

    # Change shell
    sudo chsh -s /bin/zsh

    # Restart computer
    for i in {5..1}; do
        printf "Restarting computer in %s...\\r" $i
        sleep 1
    done
    sudo reboot
}
# }}}

function parse_args() {
    case $1 in
    -h | --help)
        print_usage
        ;;
    -a | --all)
        all
        ;;
    -b | --brew)
        install_brew
        ;;
    -s | --symlink)
        symlink_repo
        ;;

    esac

}

function main() {
    if [[ "$#" -eq 0 ]]; then
        print_error
        exit 1
    fi

    parse_args "$1"

}

main "$@"
