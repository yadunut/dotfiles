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


function mkcdir() {
	mkdir -p "$1" && cd "$1"
}

[ -f /usr/local/etc/profile.d/autojump.sh ] && . /usr/local/etc/profile.d/autojump.sh


