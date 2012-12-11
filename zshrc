# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

if [ ! -d $ZSH ]; then
    echo "Looks like you're missing oh-my-zsh, trying to get it..."
    if which git >/dev/null 2>&1; then
        git clone git://github.com/robbyrussell/oh-my-zsh.git $ZSH
    else
        echo "Please install Git."
    fi
fi

# Location of custom plugins and themes.
export ZSH_CUSTOM="$HOME/.zsh"

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
export ZSH_THEME="jlefrique"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want disable red dots displayed while waiting for completion
# DISABLE_COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git vi-mode)

source $ZSH/oh-my-zsh.sh

# Detect if the $TERM environment variable starts with xterm, and change it
# to xterm-256color.
case "$TERM" in
    xterm*) TERM=xterm-256color
esac

export EDITOR="vim"
export VISUAL="vim"

# Add some emacs keybindings to the vi mode.
bindkey -M viins '^A' beginning-of-line
bindkey -M viins '^B' backward-char
bindkey -M viins '^D' delete-char-or-list
bindkey -M viins '^E' end-of-line
bindkey -M viins '^F' forward-char
bindkey -M viins '^K' kill-line
bindkey -M viins '^N' down-line-or-history
bindkey -M viins '^P' up-line-or-history
bindkey -M viins '^R' history-incremental-search-backward
bindkey -M viins '^S' history-incremental-search-forward
bindkey -M viins '^T' transpose-chars
bindkey -M viins '^Y' yank
bindkey -M viins ' ' magic-space
bindkey -M vicmd 'v' edit-command-line

# The global debian zshrc (/etc/zsh/zshrc) binds up and down to vi-*
# wigdets in vi mode, so the cursor moves to the first non-blank character on
# the line. Use emacs mode to navigate in the history to get the cursor
# directly at the end of the line.
[[ -z "$terminfo[kcuu1]" ]] || bindkey -M viins "$terminfo[kcuu1]" up-line-or-history
[[ -z "$terminfo[kcud1]" ]] || bindkey -M viins "$terminfo[kcud1]" down-line-or-history
# fixups for ncurses' application mode:
[[ "$terminfo[kcuu1]" == ""* ]] && bindkey -M viins "${terminfo[kcuu1]/O/[}" up-line-or-history
[[ "$terminfo[kcud1]" == ""* ]] && bindkey -M viins "${terminfo[kcud1]/O/[}" down-line-or-history

# Path
export PATH=${PATH}:~/android-sdk-linux/tools:~/android-sdk-linux/platform-tools
export PATH=${PATH}:~/JP/tools:~/JP/tools/debpath:~/JP/tools/visualization:~/JP/tools/PaverXmlRpc
export PYTHONPATH=$PYTHONPATH:~/JP/tools/PaverXmlRpc
