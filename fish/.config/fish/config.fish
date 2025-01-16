status is-interactive; or return

set -g fish_greeting

/opt/homebrew/bin/brew shellenv | .

if functions -q tide
    set tide_git_color_branch F5A97F
    set tide_git_icon @
    set tide_left_prompt_items pwd git newline character
    set tide_pwd_color_anchors brblue
    set tide_pwd_color_dirs blue
end

if command -qs fzf
    set -x FZF_DEFAULT_OPTS_FILE "$XDG_CONFIG_HOME/fzf/.fzfrc"

    command -qs eza; and set -x fzf_preview_dir_cmd eza -a --icons --color=always
    command -qs fd; and set fzf_fd_opts --max-depth=5
    fzf_configure_bindings --directory=\e\co  # ^⌥O
end

if command -qs micro
    set -gx VISUAL micro
    set -gx EDITOR micro
    set -gx MICRO_TRUECOLOR 1
end
