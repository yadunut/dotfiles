#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

POWERLEVEL9K_SHORTEN_DIR_LENGTH=1
POWERLEVEL9K_SHORTEN_DELIMITER=""
POWERLEVEL9K_SHORTEN_STRATEGY="truncate_from_right"

source ~/.purepower

eval "$(rbenv init -)"
eval "$(direnv hook zsh)"
eval "$(thefuck --alias)"
path+=(/Users/yadunandprem/dev/src/github.com/yadunut/to)
path+=(/Library/Apple/usr/bin)

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

for file in $HOME/dev/src/github.com/yadunut/dotfiles/zsh/*; do
    source "$file"
done
unalias run-help
autoload run-help
