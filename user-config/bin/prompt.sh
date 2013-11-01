#!/bin/sh

# This script is an attempt to generate a git-prompt with only sh

PrintGitPrompt() {
    
    local GitPrompt=""
    
    # colors
    local gpColReset='\033[0m'
    local gpColPurple='\033[1;95m'
    local gpColBGreen='\033[1;32m'
    local gpColGreen='\033[0;32m'
    local gpColBRed='\033[1;31m'
    local gpColRed='\033[0;31m'
    local gpColBCyan='\033[1;36m'
    local gpColCyan='\033[0;36m'
    local gpColBYellow='\033[1;33m'
    local gpColBlue='\033[0;34m'

    if [ "x$(git symbolic-ref HEAD 2>&1 | grep fatal)" = "x" ]
    then
    # we are in a git repo

    # format
    local gpPrefix="${gpColReset}["
    local gpSuffix="${gpColReset}] "
    local gpSeparator="${gpColReset}|"
    #prefixes
    local gpFormatBranch="${gpColPurple}"
    local gpFormatAhead="${gpColBGreen}↑"
    local gpFormatBehind="${gpColBRed}↓"
    local gpFormatEqual="${gpColBGreen}✔"
    local gpFormatStaged="${gpColBGreen}●"
    local gpFormatEdit="${gpColBCyan}✚"
    local gpFormatDel="${gpColBRed}✖"
    local gpFormatUntracked="${gpColBYellow}?"

    # staged changes
    local gpCountStaged=`git diff --name-status --staged | wc -l`

    # unstaged changes
    local gpUnstaged="$(git diff --name-status | cut -c 1)"
    local gpCountModified=$(echo "$gpUnstaged" | grep -c M)
    local gpCountDeleted=$(echo "$gpUnstaged" | grep -c D)
    local gpCountUntracked=$(git ls-files -o --exclude-standard | wc -l)

    # commits differences
    local gpBranch="$(git branch | grep --color=never '*' | tail -c +3)"
    local gpDiff="$(git rev-list --left-right origin/${gpBranch}...HEAD)"
    local gpAhead=$(echo "$gpDiff" | grep -c '>')
    local gpBehind=$(echo "$gpDiff" | grep -c '<')

    # Formatting
    local gpFirstHalf=""
    
    if [ $gpAhead != "0" ]
    then
        gpFirstHalf="${gpFormatAhead}${gpAhead}"
    fi
    if [ $gpBehind != "0" ]
    then
        gpFirstHalf="${gpFirstHalf}${gpFormatBehind}${gpBehind}"
    fi
    if [ "x${gpFirstHalf}" = "x" ]
    then
        gpFirstHalf="${gpFormatEqual}"
    fi
    
    gpFirstHalf="${gpPrefix}${gpFormatBranch}${gpBranch}${gpFirstHalf}"

    gpSecondHalf=""
    if [ $gpCountStaged != "0" ]
    then
        gpSecondHalf="${gpFormatStaged}${gpCountStaged}"
    fi
    if [ $gpCountModified != "0" ]
    then
        gpSecondHalf="${gpSecondHalf}${gpFormatEdit}${gpCountModified}"
    fi
    if [ ${gpCountDeleted} != "0" ]
    then
        gpSecondHalf="${gpSecondHalf}${gpFormatDel}${gpCountDeleted}"
    fi
    if [ ${gpCountUntracked} != "0" ]
    then
        gpSecondHalf="${gpSecondHalf}${gpFormatUntracked}${gpCountUntracked}"
    fi

    if [ "x${gpSecondHalf}" = "x" ]
    then
        GitPrompt="${gpFirstHalf}${gpSuffix}"
    else
        GitPrompt="${gpFirstHalf}${gpSeparator}${gpSecondHalf}${gpSuffix}"
    fi
    
    fi

    # detecting virtualenv
    if [[ -n "${VIRTUAL_ENV}" ]]
    then
        # we take care of printing virtualenv
        PS1="${_OLD_VIRTUAL_PS1}"
        GitPrompt="${gpColBGreen}($(basename "${VIRTUAL_ENV}"))${ResetColor} ${GitPrompt}"
    fi

    echo -ne "${GitPrompt}"
}

# for bash
if [ -z "$PROMPT_COMMAND" ]
then
    PROMPT_COMMAND=PrintGitPrompt
else
    PROMPT_COMMAND="${PROMPT_COMMAND};PrintGitPrompt"
fi

# for zsh
precmd_functions+=(PrintGitPrompt)

# adapt for other shells !
