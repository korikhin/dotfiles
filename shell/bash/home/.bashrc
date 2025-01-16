HISTFILE="$XDG_STATE_HOME/bash/history"
if [[ -w "$HISTFILE" ]]; then
    mkdir -p "${HISTFILE%/*}" && : >"$HISTFILE"
fi
