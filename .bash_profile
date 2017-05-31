export PATH="/usr/local/sbin:$PATH"
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

alias ls="ls -al"
alias development="cd ~/Documents/development"
alias opengl="cd ~/Documents/Programming/workspace/CPP/OpenGL"


alias tmux-new="tmux new -s"
alias tmux-kill-session="tmux kill-session -t"
alias tmux-kill-window="tmux kill-window -t"
alias tmux-attach="tmux attach -t"
alias mkdir="mkdir -p"

alias gitl="git log"
alias gitc="git commit -m"
alias gits="git status"
alias gita="git add -A"

alias c="clear"

function mkcdir() {
	mkdir -p "$1" && cd "$1"
}

[ -f /usr/local/etc/profile.d/autojump.sh ] && . /usr/local/etc/profile.d/autojump.sh


parse_git_branch() {
	git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

#Commands to run @start

archey

#export PS1="\h:\W \u\$(parse_git_branch)\$ "
export PS1="\h:\W \u\[\033[1;33m\$(parse_git_branch)\]\[\033[0m\] \$ "
