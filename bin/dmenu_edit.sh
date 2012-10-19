#!/bin/bash

# List files that we are likely to edit and display them with dmenu.
#
# We first search for versioned files (with git or svn). If files are not
# versioned in this folder, all files are listed with find.
#
# TODO: exclude files in wildignore.

if [ -f "${HOME}/.dmenurc" ]; then
    . "${HOME}/.dmenurc"
else
    DMENU='dmenu -i'
fi

get_files() {
    FILES=`git ls-files 2>/dev/null` && SOURCE="git" && return
    FILES=`svn list -R 2>/dev/null | grep -v ".*\/$"` && SOURCE="svn" && return
    FILES=`find .` && SOURCE="find" && return
}

get_files
echo "$FILES" | $DMENU -l 20 -p "$SOURCE"
