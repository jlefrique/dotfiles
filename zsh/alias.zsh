### Alias

alias ls='ls --color'
alias ll='ls -lh'
alias grep='grep --color'

alias pssh='parallel-ssh'
alias pscp='parallel-scp'
alias prsync='parallel-rsync'
alias pnuke='parallel-nuke'
alias pslurp='parallel-slurp'

# Extract most known archives with one command
extract () {
    if [ -f $1 ] ; then
        case $1 in
            *.tar.bz2)   tar xjf $1     ;;
            *.tar.gz)    tar xzf $1     ;;
            *.bz2)       bunzip2 $1     ;;
            *.rar)       unrar e $1     ;;
            *.gz)        gunzip $1      ;;
            *.tar)       tar xf $1      ;;
            *.tbz2)      tar xjf $1     ;;
            *.tgz)       tar xzf $1     ;;
            *.tag.xz)    tar xJf $1     ;;
            *.zip)       unzip $1       ;;
            *.Z)         uncompress $1  ;;
            *.7z)        7z x $1        ;;
            *.ipk)       ar x $1        ;;
            *)     echo "'$1' cannot be extracted via extract()" ;;
         esac
     else
         echo "'$1' is not a valid file"
     fi
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
