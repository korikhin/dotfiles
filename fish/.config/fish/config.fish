# Tide renders the prompt in a non-interactive background fish,
# so its globals must be set before the interactive guard
if functions -q tide
    set -g tide_left_prompt_items pwd git newline character
    set -g tide_prompt_add_newline_before false

    # Tide's async renderer can't see fish 4's global
    # key bindings and falls back to vi mode, showing ❮
    set -g tide_character_vi_icon_default ❯
    set -g tide_character_icon ❯

    set -g tide_pwd_color_anchors brblue
    set -g tide_pwd_color_dirs blue

    set -g tide_git_color_branch magenta
    set -g tide_git_icon @
end

status is-interactive; or return

set -g fish_greeting

/opt/homebrew/bin/brew shellenv | source

if command -qs fzf
    set -gx FZF_DEFAULT_OPTS_FILE "$XDG_CONFIG_HOME/fzf/.fzfrc"

    command -qs eza; and set -gx fzf_preview_dir_cmd eza -a --icons --color=always
    command -qs fd; and set -g fzf_fd_opts --max-depth=5
    fzf_configure_bindings --directory=\e\co  # ^⌥O
end

if command -qs micro
    set -gx VISUAL micro
    set -gx EDITOR micro
    set -gx MICRO_TRUECOLOR 1
end
