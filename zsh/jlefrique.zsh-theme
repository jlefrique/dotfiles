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
    local git='$(git_prompt_info)'
    local prompt='%F{red}»%f'

    echo "${user}${at}${host} ${dir} ${git}${prompt} "
}

PROMPT="$(make_prompt)"
PROMPT2='%F{red}\ %f'

# vi-mode indicator
MODE_INDICATOR='%F{green}%B<%b%F{green}<<%f'

# Right side
local return_code='%(?..%F{red}%? ↵%f)'

if `type vi_mode_prompt_info >/dev/null 2>&1` ; then
    RPS1='$(vi_mode_prompt_info) ${return_code}'
else
    RPS1='${return_code}'
fi

# Git information
ZSH_THEME_GIT_PROMPT_PREFIX="%F{yellow}<"
ZSH_THEME_GIT_PROMPT_SUFFIX=">%f "
ZSH_THEME_GIT_PROMPT_CLEAN=""
ZSH_THEME_GIT_PROMPT_DIRTY="⚡"
