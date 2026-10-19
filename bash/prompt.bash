# Bash prompt:
#   [exit code] user@host[jobs] dir branch!?+ $
# The host is purple, which tells bash apart from zsh at a glance.
# Source it from ~/.bashrc:
#   [ -f ~/dotfiles/bash/prompt.bash ] && . ~/dotfiles/bash/prompt.bash

# Prints the git branch followed by ! (unstaged), ? (untracked) and + (staged)
# markers and a space, or nothing outside a git work tree.
__prompt_git() {
    local branch status markers=""
    branch=$(git symbolic-ref --short -q HEAD 2> /dev/null ||
             git rev-parse --short HEAD 2> /dev/null) || return 0
    status=$(git status --porcelain 2> /dev/null)
    grep -q '^.[MD]' <<< "$status" && markers+="!"
    grep -q '^??' <<< "$status" && markers+="?"
    grep -q '^[MADRC]' <<< "$status" && markers+="+"
    # Escape what bash would expand in PS1: branch names may contain $( ).
    branch=${branch//\\/\\\\}
    branch=${branch//\$/\\\$}
    branch=${branch//\`/\\\`}
    printf '%s%s ' "$branch" "$markers"
}

# Rebuilds PS1 before each prompt, keeping the previous command's exit code.
__prompt_command() {
    local code=$?
    local reset='\[\e[0m\]' red='\[\e[31m\]' green='\[\e[32m\]'
    local yellow='\[\e[33m\]' cyan='\[\e[36m\]' white='\[\e[37m\]'
    local purple='\[\e[35m\]'
    local user_color=$green host_color=$purple jobs_count

    [ "$EUID" -eq 0 ] && user_color=$red
    jobs_count=$(jobs -p | wc -l)

    PS1=""
    [ "$code" -ne 0 ] && PS1+="${red}${code}${reset} "
    PS1+="${user_color}\u${reset}${cyan}@${reset}${host_color}\h${reset}"
    [ "$jobs_count" -gt 0 ] && PS1+="[${jobs_count}]"
    PS1+=" \w ${yellow}$(__prompt_git)${reset}${white}\\\$${reset} "
}

PROMPT_DIRTRIM=4
PROMPT_COMMAND="__prompt_command${PROMPT_COMMAND:+; $PROMPT_COMMAND}"
