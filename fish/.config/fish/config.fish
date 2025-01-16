status is-interactive; or return
set -g fish_greeting

/opt/homebrew/bin/brew shellenv | .
set -gx HOMEBREW_NO_AUTO_UPDATE 1

if functions -q tide
    set tide_left_prompt_items pwd git newline character
    set tide_prompt_add_newline_before false
    set tide_pwd_color_anchors brblue
    set tide_pwd_color_dirs blue
    set tide_git_color_branch F5A97F
    set tide_git_icon @
end

if command -qs fzf
    set -x FZF_DEFAULT_OPTS_FILE "$XDG_CONFIG_HOME/fzf/.fzfrc"
    fzf_configure_bindings --directory=\e\co # ^⌥O
    command -qs fd; and set fzf_fd_opts --max-depth 5
    command -qs eza; and set -x fzf_preview_dir_cmd eza \
        --all --group-directories-first --icons=always --color=always
end

if command -qs micro
    set -gx VISUAL micro
    set -gx EDITOR micro
    set -gx MICRO_TRUECOLOR 1
end

command -qs go; and set -gx GOPATH "$HOME/Developer/go"

# FUNCTIONS

functions -c help _help
function help -d 'Show help for the fish shell or a command'
    _help $argv &>/dev/null; or begin
        command -qs bat; and $argv --help | bat -l help -p; or $argv --help
        return $pipestatus[1]
    end
end

function tile -d 'Add spacer to the Dock'
    set -l type small-spacer-tile
    test "$argv[1]" = --wide; and set type spacer-tile
    defaults write com.apple.dock persistent-apps -array-add '{"tile-type"="'$type'";}'
    osascript -e 'tell application "Dock" to quit'
end

# ALIASES

command -qs micro; and alias m micro
command -qs batman; and alias man batman
command -qs lazygit; and alias lzg lazygit
command -qs lazydocker; and alias lzd lazydocker

if command -qs eza
    alias ls 'eza --group-directories-first --icons=always'
    alias lt 'eza --tree --level=2 --group-directories-first --icons=always'
    alias la 'eza -abhlm --time-style=long-iso --group-directories-first --git-repos --no-user'
end
