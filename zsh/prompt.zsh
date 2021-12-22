### Prompt

# Tun on command substitution in the prompt
setopt prompt_subst

# Configure vcs_info
autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git hg
zstyle ':vcs_info:(hg*|git*):*' get-revision true
zstyle ':vcs_info:*' formats "%F{yellow}(%s) %b%u%c%f "
zstyle ':vcs_info:*' actionformats "%F{yellow}(%s) %b[%a]%u%c%f "
zstyle ':vcs_info:*' unstagedstr "!"
zstyle ':vcs_info:*' stagedstr "+"

precmd() {
    vcs_info
}

# Vi mode indicator in prompt
function zle-line-init zle-keymap-select {
    zle reset-prompt
}
zle -N zle-line-init
zle -N zle-keymap-select

zstyle -e ':vcs_info:(hg*|git*):*' \
	check-for-changes 'estyle-cfc && reply=( true ) || reply=( false )'

function estyle-cfc() {
    local d
    local -a cfc_dirs
    cfc_dirs=(
        ${HOME}/src/linux
    )

    for d in ${cfc_dirs}; do
        d=${d%/##}
        [[ $PWD == $d(|/*) ]] && return 1
    done
    return 0
}

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
    local jobs='%(1j.[%j].)'
    local prompt=${${KEYMAP/vicmd/'%F{red}'}/(main|viins)/'%F{white}'}'»%f'

    echo "${user}${at}${host}${jobs} ${dir} ${vcs_info_msg_0_}${prompt} "
}

PROMPT='$(make_prompt)'
PROMPT2='%F{red}\ %f'

# Right side
local return_code='%(?..%F{red}%? ↵%f)'
RPS1='${return_code}'
