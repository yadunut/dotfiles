# vim:ft=zsh ts=2 sw=2 sts=2
PROMPT='$(git_super_status)%{$fg[yellow]%}%#%{$reset_color%} '
RPROMPT='%{$fg[green]%}$(shrink_path -f)%{$reset_color%}'
