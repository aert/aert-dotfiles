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

# Customize to your needs...

# --- AERT --------------------------------------------------------------------
zstyle ":completion:*:commands" rehash 1

export WORKON_HOME=~/Code/.envs
export PROJECT_HOME=~/Code
source /usr/local/bin/virtualenvwrapper.sh

export ANDROID_HOME=~/bin/android-studio/sdk
export PATH=~/bin:~/bin/android-studio/sdk/platform-tools:~/bin/android-studio/sdk/tools:$PATH
export PATH=~/bin/gradle-1.10/bin:$PATH
alias npm-exec='PATH=$(npm bin):$PATH'
alias bower-exec='npm-exec bower'

export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

alias ouvrir='xdg-open'
alias cdgit='cd $(git rev-parse --show-cdup)'

[ -s "/home/ari/.dnx/dnvm/dnvm.sh" ] && . "/home/ari/.dnx/dnvm/dnvm.sh" # Load dnvm

export NVM_DIR="/home/ari/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

# History Search
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end

bindkey  '^[[A'  history-beginning-search-backward-end
bindkey  '^[[B'  history-beginning-search-forward-end

# make Ctrl+U delete from cursor to the beginning of the line
bindkey \^U backward-kill-line
