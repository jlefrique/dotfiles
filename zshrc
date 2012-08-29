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

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
export ZSH_THEME="jreese"

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
plugins=(git)

source $ZSH/oh-my-zsh.sh

# Detect if the $TERM environment variable starts with xterm, and change it
# to xterm-256color.
case "$TERM" in
      xterm*) TERM=xterm-256color
esac

export EDITOR="vim"
export PATH=${PATH}:~/android-sdk-linux/tools:~/android-sdk-linux/platform-tools
export PATH=${PATH}:~/JP/tools:~/JP/tools/debpath:~/JP/tools/visualization:~/JP/tools/PaverXmlRpc
export PYTHONPATH=$PYTHONPATH:~/JP/tools/PaverXmlRpc

