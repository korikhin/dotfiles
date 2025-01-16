if status is-interactive
    set -g fish_greeting

    /opt/homebrew/bin/brew shellenv | source
    set -gx HOMEBREW_NO_AUTO_UPDATE 1

    if functions -q tide
        set tide_prompt_add_newline_before false
        set tide_left_prompt_items pwd git newline character
        set tide_pwd_color_anchors brblue
        set tide_pwd_color_dirs blue
        set tide_git_color_branch f5a97f
        set tide_git_icon @
    end
    if command -sq fzf
        set -x FZF_DEFAULT_OPTS_FILE $XDG_CONFIG_HOME/fzf/.fzfrc
        command -sq eza && set -x fzf_preview_dir_cmd eza --all --group-directories-first --icons always --color always
        command -sq fd && set fzf_fd_opts --max-depth 5
        fzf_configure_bindings --directory=\e\co
    end
    if command -sq micro
        set -gx VISUAL micro
        set -gx EDITOR micro
        set -gx MICRO_TRUECOLOR 1
    end
    if command -sq go
        set -gx GOPATH $HOME/Projects/go
        fish_add_path $GOPATH/bin
    end

    # FUNCTIONS

    function tile -d 'Add spacer to macOS Dock'
        if not contains -- $argv[1] small regular
            echo 'Usage: tile [small|regular]'
            return 1
        end

        set -l type spacer-tile
        if test $argv[1] = small
            set type small-spacer-tile
        end

        defaults write com.apple.dock persistent-apps -array-add "{\"tile-type\"=\"$type\";}"
        killall Dock
    end

    # ALIASES

    command -sq micro && alias m micro
    command -sq bat && alias cat bat
    command -sq batman && alias man batman
    command -sq rg && alias grep rg
    command -sq lazygit && alias lz lazygit
    command -sq lazydocker && alias lzd lazydocker
    if command -sq eza
        alias ls 'eza --group-directories-first --icons=always'
        alias lt 'eza --tree --level=2 --group-directories-first --icons=always'
        alias la 'eza -abhlm --time-style=long-iso --group-directories-first --git-repos --no-user'
    end
end
