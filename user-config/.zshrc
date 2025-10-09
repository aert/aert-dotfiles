# zsh profiling
# https://esham.io/2018/02/zsh-profiling
# zmodload zsh/zprof
# zmodload zsh/zpty

# Path to your oh-my-zsh installation.
export ZSH=~/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
#ZSH_THEME="cloud"
#ZSH_THEME="amuse"
ZSH_THEME="miloshadzic"
# ZSH_THEME="spaceship"
# ZSH_THEME=powerlevel10k/powerlevel10k
# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
HIST_STAMPS="yyyy-mm-dd"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
# NOTE:  zsh-syntax-highlighting must be at the end rake-fast rails 
plugins=(asdf docker docker-compose git fzf-tab zsh-autosuggestions uv mise)
source $ZSH/oh-my-zsh.sh

# plugin: zsh_autosuggest
# Color Codes: https://en.wikipedia.org/wiki/ANSI_escape_code
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=243'
export ZSH_AUTOSUGGEST_STRATEGY=(history completion)
export ZSH_AUTOSUGGEST_USE_ASYNC=true
bindkey '^ ' autosuggest-accept

# --- AERT --------------------------------------------------------------------

SPACESHIP_PROMPT_ADD_NEWLINE=false
SPACESHIP_CHAR_SYMBOL="❯"
SPACESHIP_CHAR_SUFFIX=" "

SPACESHIP_PROMPT_ORDER=(
  time          # Time stampts section
  user          # Username section
  dir           # Current directory section
# host          # Hostname section
  git           # Git section (git_branch + git_status)
# hg            # Mercurial section (hg_branch  + hg_status)
# package       # Package version
# node          # Node.js section
  ruby          # Ruby section
# elixir        # Elixir section
# xcode         # Xcode section
# swift         # Swift section
  golang        # Go section
# php           # PHP section
  rust          # Rust section
# haskell       # Haskell Stack section
# julia         # Julia section
# docker        # Docker section
#  aws           # Amazon Web Services section
  venv          # virtualenv section
# conda         # conda virtualenv section
  pyenv         # Pyenv section
# dotnet        # .NET section
# ember         # Ember.js section
  kubecontext   # Kubectl context section
  exec_time     # Execution time
  line_sep      # Line break
# battery       # Battery level and status
  vi_mode       # Vi-mode indicator
  jobs          # Background jobs indicator
  exit_code     # Exit code section
  char          # Prompt character
)
# source ~/.zsh_plugins.sh

#export WORKON_HOME=~/Code/.envs
#export PROJECT_HOME=~/Code/venv
#source /usr/local/bin/virtualenvwrapper.sh

#source /usr/etc/git-extras-completion.zsh
# source <(kubectl completion zsh)
# source <(helm completion zsh)

export PATH=~/bin:~/bin/my_scripts:$PATH

# If gnupg2 and gpg-agent 2.x are used, be sure to set the environment variable GPG_TTY
export GPG_TTY=$TTY

#-- dev tools installer
# . $HOME/.asdf/asdf.sh
eval "$($HOME/.local/bin/mise activate zsh)"

export PATH="$HOME/.local/bin:$PATH"
export PATH="$PATH:/opt/nvim-linux64/bin"

# #-- pyenv
# export PATH="$HOME/.pyenv/bin:$PATH"
# eval "$(pyenv init -)"
# eval "$(pyenv virtualenv-init -)"

#-- pipenv
export SHELL=/bin/zsh

alias ouvrir='xdg-open'
alias cb='xclip -sel clip'
alias cdgit='cd $(git rev-parse --show-cdup)'
alias alert='notify-send -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'
alias tcopy='tmux show-buffer | cb && alert "$(tmux show-buffer)"'
alias sm='smerge .'
alias be='bundle exec'
alias k='kubectl'

# ssh-agent
# /usr/bin/keychain --nogui --quiet ~/.ssh/id_ed25519
# . $HOME/.keychain/$HOST-sh

#-- node
# export NVM_DIR="/home/ari/.nvm"
## [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh" --no-use


#-- yarn
export PATH="$HOME/.yarn/bin:$PATH"

export XZ_OPT='-T0 -9'
export EDITOR="nvim"

# export RUBY_CONFIGURE_OPTS="--with-openssl-dir=/opt/openssl-1.1.1o/"

export BAT_THEME="zenburn" 

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND='ag --nocolor -g ""'

# alias x="exa -l --time-style long-iso --git"
alias x="lsd -l --date relative"
alias n="nvim"
alias xt="lsd -l --date relative --total-size"
alias lg="lazygit"
alias ldoc="lazydocker"
alias vpn_from_ssh="sshuttle 0/0 --dns -r"
alias my-iozone="iozone -a -I -b iozone-results.xls"
alias mosh="export LC_ALL=\"en_US.UTF8\" && mosh"
alias mux=tmuxinator
alias dockly="docker run -it --rm -v /var/run/docker.sock:/var/run/docker.sock lirantal/dockly"

chpwd() {
  x
}

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

. "$HOME/.atuin/bin/env"

eval "$(atuin init zsh)"
eval "$(zoxide init zsh)"
