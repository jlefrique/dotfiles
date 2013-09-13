# Autocomplete for paver.
_paver () {
    declare tasks

    tasks=$(paver -hq | awk '/^  ([a-zA-Z][a-zA-Z0-9_]+)/ {print $1}')
    _arguments "1: :(${tasks})" \
               "2: :_files"
}

compdef _paver paver
