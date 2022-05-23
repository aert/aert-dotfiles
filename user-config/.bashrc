
#-- asdf
. $HOME/.asdf/asdf.sh
. $HOME/.asdf/completions/asdf.bash

#-- yarn
export PATH="$HOME/.yarn/bin:$PATH"

# aliases
alias ouvrir='xdg-open'
alias cb='xclip -sel clip'
alias cdgit='cd $(git rev-parse --show-cdup)'
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'
alias tcopy='tmux show-buffer | cb && alert "$(tmux show-buffer)"'
alias sm='smerge .'
alias be='bundle exec'
alias k='kubectl'

alias x="exa -l --time-style long-iso --git"
alias vpn_from_ssh="sshuttle 0/0 --dns -r"

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
