# Autocomplete for paver.
_paver() {
    for TASK in `paver -hq | awk '/^  ([a-zA-Z][a-zA-Z0-9_]+)/ {print $1}'`; do
      compadd "$TASK"
    done
}

compdef _paver paver
