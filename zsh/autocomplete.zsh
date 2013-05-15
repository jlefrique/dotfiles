# Autocomplete for paver.
_paver() {
    TASKS=`paver -hq | awk '/^  ([a-zA-Z][a-zA-Z0-9_]+)/ {print $1}'`
    _arguments "1: :(${TASKS})"
}

compdef _paver paver
