# Zsh theme

function make_prompt() {
    local host_color
    if [[ -n "$SSH_CLIENT" || -n "$SSH2_CLIENT" ]]; then
        host_color='%F{yellow}'
    else
        host_color='%F{green}'
    fi

    local user='%(!.%F{red}.%F{green})%n%f' # red if root, else green
    local at='%F{cyan}@%f'
    local host="$host_color%m%f"
    local dir='%4~'
    local vcs='%F{yellow}$(git_prompt_info)$(hg_prompt_info)%f'
    local jobs='%(1j.[%j].)'

    local prompt
    if `type vi_mode_prompt_info > /dev/null 2>&1` ; then
        prompt='$(vi_mode_prompt_info)»%f'
    else
        prompt='»'
    fi

    echo "${user}${at}${host}${jobs} ${dir} ${vcs}${prompt} "
}

# vi-mode indicator
MODE_INDICATOR='%F{red}'

PROMPT="$(make_prompt)"
PROMPT2='%F{red}\ %f'

# Right side
local return_code='%(?..%F{red}%? ↵%f)'
RPS1='${return_code}'

# Git information
ZSH_THEME_GIT_PROMPT_PREFIX="±"
ZSH_THEME_GIT_PROMPT_SUFFIX=""
ZSH_THEME_GIT_PROMPT_CLEAN=" "
ZSH_THEME_GIT_PROMPT_DIRTY="! "

# Hg information
ZSH_THEME_HG_PROMPT_PREFIX="+"
ZSH_THEME_HG_PROMPT_SUFFIX=""
ZSH_THEME_HG_PROMPT_CLEAN=" "
ZSH_THEME_HG_PROMPT_DIRTY="! "
