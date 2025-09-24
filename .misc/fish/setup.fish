# NOTE: Run me once

set -Ux XDG_CONFIG_HOME "$HOME/.config"
set -Ux XDG_CACHE_HOME  "$HOME/Library/Caches"
set -Ux XDG_DATA_HOME   "$HOME/Library/Application Support"
set -Ux XDG_STATE_HOME  "$HOME/Library/Application Support"

command -qs go; and fish_add_path "$HOME/Developer/go/bin"

tide configure \
    --auto \
    --style Lean \
    --prompt_colors '16 colors' \
    --show_time No \
    --lean_prompt_height 'Two lines' \
    --prompt_connection Dotted \
    --prompt_spacing Sparse \
    --icons 'Many icons' \
    --transient Yes
