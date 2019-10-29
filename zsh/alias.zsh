alias c="clear"
alias copypwd="pwd | pbcopy"
alias h="~/dev/src/github.com/yadunut"
alias git='hub'
alias lg="lazygit"
alias cat="bat"

# Git aliases
alias g='git'
alias gst='git status'
alias gpsup='git push --set-upstream origin $(git-branch-current)'
alias gl='git pull'
alias gp='git push'
alias gpf!='git push --force'
alias gra='git remote add'
alias grv='git remote -v'
alias gc='git commit -v'
alias gc!='git commit -v --amend'
alias gcm='git checkout master'
alias gbd='git branch -d'
alias gbD='git branch -D'
alias gco='git checkout'
alias gcb='git checkout -b'
alias grbA='git rebase --abort'
alias grbC='git rebase --continue'

# Tmux Alias
alias t='tmux'
alias ta='tmux attach -t'
alias tad='tmux attach -d -t'
alias ts='tmux new-session -s'
alias tl='tmux list-sessions'
alias tksv='tmux kill-server'
alias tkss='tmux kill-session -t'
