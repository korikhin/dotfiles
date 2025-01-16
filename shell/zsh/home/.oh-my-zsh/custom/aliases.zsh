alias zshc="micro $ZDOTDIR/.zshrc"
alias omzc="micro $ZSH_CUSTOM/aliases.zsh"
alias p10c="micro $POWERLEVEL9K_CONFIG_FILE"

alias c=clear
alias m=micro

alias cat=bat
alias grep=rg
alias man=batman
alias find='fd --hidden --follow'
alias ls='eza --group-directories-first --icons=always'
alias lt='eza --group-directories-first --icons=always --level=2 -T'
alias la='eza --group-directories-first --git-repos --time-style=long-iso --no-user -abhlm'

alias lz=lazygit
alias lzd=lazydocker

help() {
    "$@" --help 2>&1 | bat -l help -p
}

# Add a spacer to the Dock
dock() {
    [[ ! $1 =~ ^[0-1]?$ ]] && {
        echo 'Usage: dock [0|1] (0: regular spacer [default], 1: small spacer)'
        return 1
    }
    defaults write com.apple.dock persistent-apps -array-add "{\"tile-type\"=\"${1:+small-}spacer-tile\";}"
    killall Dock
}

_fzf_comprun() {
    local command=$1
    shift

    case "$command" in
    open | micro | zed) fzf --preview-window=right:60% --preview='bat --color=always --style=numbers --line-range=:200 {}' "$@" ;;
    *) fzf "$@" ;;
    esac
}

_fzf_compgen_path() {
    fd --hidden --follow . "$1"
}

_fzf_compgen_dir() {
    fd --hidden --follow --type d . "$1"
}
