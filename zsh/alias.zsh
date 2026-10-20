### Alias

alias ls='ls --color'
alias ll='ls -lh'
alias grep='grep --color'
alias vim='nvim'

alias pssh='parallel-ssh'
alias pscp='parallel-scp'
alias prsync='parallel-rsync'
alias pnuke='parallel-nuke'
alias pslurp='parallel-slurp'

# Extract most known archives with one command
extract () {
    for file in "$@"; do
        # Machine-specific formats (e.g. in ~/.zshrc.local) take precedence.
        if (( $+functions[extract_local] )) && extract_local "$file"; then
            continue
        fi
        if [ -f "$file" ] ; then
            case "$file" in
                *.tar.bz2)   tar xjf "$file"     ;;
                *.tar.gz)    tar xzf "$file"     ;;
                *.bz2)       bunzip2 "$file"     ;;
                *.rar)       unrar e "$file"     ;;
                *.gz)        gunzip "$file"      ;;
                *.tar)       tar xf "$file"      ;;
                *.tbz2)      tar xjf "$file"     ;;
                *.tgz)       tar xzf "$file"     ;;
                *.tar.xz)    tar xJf "$file"     ;;
                *.zip)       unzip "$file"       ;;
                *.Z)         uncompress "$file"  ;;
                *.7z)        7z x "$file"        ;;
                *.ipk)       ar x "$file"        ;;
                *)     echo "'$file' cannot be extracted via extract()" ;;
            esac
        else
            echo "'$file' is not a valid file"
        fi
    done
}

# Serve current directory tree at http://$HOSTNAME:8000/
alias servethis='python3 -m http.server'
alias servethis2='python -m SimpleHTTPServer'

alias ips="ip -c -br -4  -h a show"
alias git-root='cd $(git root)'

alias ag='ag --nobreak --noheading'
alias ff='find . | egrep'

alias myip='curl ifconfig.me/ip'
alias wttr='curl wttr.in'
alias wttr_now='curl "wttr.in?0"'

alias evince='atril'

# Opens (or attaches to) a tmux session named after a directory, the current
# one by default, starting in it. Inside tmux, switches to it instead of nesting.
tdir() {
    local dir="${1:-$PWD}"
    local name="$(basename "$dir" | tr '.:' '--')"
    if [ -n "$TMUX" ]; then
        tmux has-session -t "=$name" 2> /dev/null || tmux new-session -d -s "$name" -c "$dir"
        tmux switch-client -t "=$name"
    else
        tmux new-session -A -s "$name" -c "$dir"
    fi
}
