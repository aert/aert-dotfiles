# zsh profiling (https://esham.io/2018/02/zsh-profiling): uncomment, then run `zprof`
# zmodload zsh/zprof

# --- oh-my-zsh ---------------------------------------------------------------

export ZSH=~/.oh-my-zsh
ZSH_THEME="miloshadzic"

DISABLE_AUTO_UPDATE="true"
COMPLETION_WAITING_DOTS="true"
# Faster git status in large repos: untracked files don't mark the repo dirty
DISABLE_UNTRACKED_FILES_DIRTY="true"
HIST_STAMPS="yyyy-mm-dd"

# Plugins: ~/.oh-my-zsh/plugins/* and ~/.oh-my-zsh/custom/plugins/*
plugins=(docker docker-compose git fzf-tab zsh-autosuggestions uv mise)
source $ZSH/oh-my-zsh.sh

# plugin: zsh-autosuggestions (colors: https://en.wikipedia.org/wiki/ANSI_escape_code)
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=243'
export ZSH_AUTOSUGGEST_STRATEGY=(history completion)
export ZSH_AUTOSUGGEST_USE_ASYNC=true
bindkey '^ ' autosuggest-accept

# --- AERT --------------------------------------------------------------------

# PATH (first wins): yarn, bun, ~/.local/bin, ~/bin, my_scripts
export PATH="$HOME/.yarn/bin:$HOME/.bun/bin:$HOME/.local/bin:$HOME/bin:$HOME/bin/my_scripts:$PATH"

# If gnupg2 and gpg-agent 2.x are used, GPG_TTY must be set
export GPG_TTY=$TTY

# Dev tools (mise puts its tools ahead of the PATH above)
eval "$($HOME/.local/bin/mise activate zsh)"

export SHELL=/bin/zsh
export EDITOR="nvim"
export BAT_THEME="zenburn"
export XZ_OPT='-T0 -9'
export P_REVIEW="$HOME/Sync/Mobile/00_review"
export CLAUDE_CODE_MAX_OUTPUT_TOKENS=64000

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND="rg --files --hidden --glob '!.git'"

alias ouvrir='xdg-open'
alias cb='xclip -sel clip'
alias cdgit='cd $(git rev-parse --show-cdup)'
alias alert='notify-send -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'
alias tcopy='tmux show-buffer | cb && alert "$(tmux show-buffer)"'
alias sm='smerge .'
alias be='bundle exec'
alias k='kubectl'

alias x="lsd -l --date relative"
alias xt="lsd -l --date relative --total-size"
alias n="nvim"
alias lg="lazygit"
alias ldoc="lazydocker"
alias vpn_from_ssh="sshuttle 0/0 --dns -r"
alias my-iozone="iozone -a -I -b iozone-results.xls"
alias mosh="export LC_ALL=\"en_US.UTF8\" && mosh"
alias mux=tmuxinator
alias dockly="docker run -it --rm -v /var/run/docker.sock:/var/run/docker.sock lirantal/dockly"
alias ncli="n-cli"
alias weather="curl 'https://wttr.in/xls?format=v2'"

# List the directory after every cd
chpwd() {
  [[ -o interactive ]] && x
}

. "$HOME/.atuin/bin/env"
eval "$(atuin init zsh)"
eval "$(zoxide init zsh)"

# macOS (iTerm2)
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
