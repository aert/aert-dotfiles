# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block, everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# zsh profiling
# https://esham.io/2018/02/zsh-profiling
# zmodload zsh/zprof
zmodload zsh/zpty

# Path to your oh-my-zsh installation.
export ZSH=/home/ari/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
#ZSH_THEME="cloud"
#ZSH_THEME="amuse"
#ZSH_THEME="miloshadzic"
# ZSH_THEME="spaceship"
ZSH_THEME=powerlevel10k/powerlevel10k
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
plugins=(git encode64 zsh-autosuggestions zsh-syntax-highlighting)
source $ZSH/oh-my-zsh.sh

# plugin: zsh_autosuggest
# Color Codes: https://en.wikipedia.org/wiki/ANSI_escape_code
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=125'
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
# kubecontext   # Kubectl context section
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
#source <(kubectl completion zsh)

# export ANDROID_HOME=$HOME/Android/Sdk
# export PATH=$ANDROID_HOME/tools:$PATH
# export PATH=$ANDROID_HOME/platform-tools:$PATH
# export PATH=~/bin/gradle-1.10/bin:$PATH
export PATH=~/bin:~/bin/my_scripts:$PATH

#-- rbenv
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

export PATH="$HOME/.local/bin:$PATH"

#-- pyenv
export PATH="$HOME/.pyenv/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

#-- pipenv
export SHELL=/bin/zsh

alias ouvrir='xdg-open'
alias cb='xclip -sel clip'
alias cdgit='cd $(git rev-parse --show-cdup)'
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'
alias tcopy='tmux show-buffer | cb && alert "$(tmux show-buffer)"'
alias sm='smerge .'

#-- node
# export NVM_DIR="/home/ari/.nvm"
## [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh" --no-use

#-- yarn
export PATH="$HOME/.yarn/bin:$PATH"

export PATH=$PATH:/usr/local/go/bin
export GOPATH=$HOME/Code/gowork
export PATH=$PATH:$GOPATH/bin
export PATH="$HOME/.cargo/bin:$PATH"

export BAT_THEME="zenburn" 

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
# fzf + ag configuration
export FZF_DEFAULT_COMMAND='ag --nocolor -g ""'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="$FZF_DEFAULT_COMMAND"

export FZF_DEFAULT_OPTS='
--layout=reverse
--height 50%
--border
'

# tmuxinator
export EDITOR='vim'
alias mux_tdup="tmuxinator start td"
alias mux_tddown="tmuxinator stop td; cd ~/Code/tolaroid/tolaroid-api && make compose_down"
alias mux_otup="tmuxinator start ot"
alias mux_otdown="tmuxinator stop ot; cd ~/Code/orchtech/ot-hr-saas && make compose_down"
alias mux_accup="tmuxinator start acc"
alias mux_accdown="tmuxinator stop acc; cd ~/Code/accelerator/acceleratorapp && make compose_down"
alias mux_scriptxup="tmuxinator start scriptx"
alias mux_scriptxdown="tmuxinator stop scriptx; cd ~/Code/scriptx/scriptx-io-rails-service && make compose_down"
alias mux_qoteitup="tmuxinator start qoteit"
alias mux_qoteitdown="tmuxinator stop qoteit; cd ~/Code/qoteit/qoteit-web && make compose_down"
# alias ssh='TERM=xterm-256color ssh' # don't send custom $TERM with italics

alias x="exa -l --time-style long-iso --git"


chpwd() {
  x
}

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
