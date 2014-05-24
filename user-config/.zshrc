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
