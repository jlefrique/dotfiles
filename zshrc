### Basics

# /etc/zprofile resets PATH, among other things, so we need to
# re-source.
# source ~/.zshenv
# In the case of an interactive, non-login shell, this leads to
# repetitions in PATH. Fortunately, zsh to the rescue.
export -U PATH=$PATH

export EDITOR="vim"
export VISUAL="vim"
export PAGER='less -X'
export LESS='-R'

# Notify asynchronously of background job completion, don't
# synchronize on prompt display.
setopt notify
# NO BEEPING!
unsetopt beep
# Allow comments
setopt interactive_comments
# Report time and CPU usage for long commands.
export REPORTTIME=5

# Detect if the $TERM environment variable starts with xterm, and change it
# to xterm-256color.
case "$TERM" in
    xterm*) TERM=xterm-256color
esac

### Completion
zstyle ':completion:*' completer _expand _complete _ignored _approximate
zstyle ':completion:*' expand prefix suffix
zstyle ':completion:*' ignore-parents parent
zstyle ':completion:*' max-errors 2
zstyle ':completion:*' squeeze-slashes true
zstyle ':completion:*' verbose true
zstyle ':completion:*' menu select
autoload -Uz compinit
compinit

### History management
HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000
# Allow concurrent writing to the history file, write with timestamps,
# suppress duplicate commands.
setopt appendhistory extended_history hist_save_no_dups histignorespace

### Source other zsh config files
for file in ~/.zsh/*.zsh; do
    [ -f $file ] && source $file
done

### Machine specializations
if [ -f ~/.zshrc.local ]; then
    source ~/.zshrc.local
fi
