HISTFILE="$XDG_STATE_HOME/bash/history"
[[ -w "$histfile" ]] || { mkdir -p "$(dirname "$histfile")" && : >"$histfile" }
