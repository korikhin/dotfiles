if [[ -r "$XDG_CACHE_HOME/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
    . "$XDG_CACHE_HOME/p10k-instant-prompt-${(%):-%n}.zsh"
fi

setopt \
    HIST_FIND_NO_DUPS \
    HIST_IGNORE_ALL_DUPS \
    HIST_IGNORE_DUPS \
    HIST_IGNORE_SPACE \
    HIST_SAVE_NO_DUPS \
    INC_APPEND_HISTORY \
    SHARE_HISTORY

SAVEHIST=5000
HISTSIZE=5000
HISTDUP=erase
HISTORY_IGNORE='(c|m|lz|lzd|pwd|exit|cd(| *)|ls(| *)|lt(| *)|la(| *))'

HISTFILE="$XDG_STATE_HOME/zsh/history"
export PYTHON_HISTORY="$XDG_STATE_HOME/python/history"

for histfile in "$HISTFILE" "$PYTHON_HISTORY"; do
    [[ -w "$histfile" ]] || { mkdir -p ${histfile:h} && : > $histfile }
done

HYPHEN_INSENSITIVE=true
DISABLE_UNTRACKED_FILES_DIRTY=true
export HOMEBREW_NO_AUTO_UPDATE=1

zstyle ':omz:update' mode auto
zstyle ':omz:update' frequency 7
zstyle ':omz:plugins:ssh-agent' lazy yes
zstyle ':omz:plugins:ssh-agent' quiet yes
zstyle ':omz:plugins:ssh-agent' lifetime 14400

plugins=(
    poetry
    poetry-env
    ssh-agent
    zsh-autosuggestions
    zsh-syntax-highlighting
)

if command -v micro >/dev/null; then
    export VISUAL=micro
    export EDITOR=micro
    export MICRO_TRUECOLOR=1
fi

if command -v fzf >/dev/null; then
    export FZF_COMPLETION_TRIGGER='~~'
    export FZF_COMPLETION_OPTS='--margin=0 --no-separator'
    export FZF_DEFAULT_COMMAND='fd --hidden --follow --type f'
    export FZF_DEFAULT_OPTS_FILE="$XDG_CONFIG_HOME/fzf/.fzfrc"

    . <(fzf --zsh)
fi

if command -v go >/dev/null; then
    export GOPATH="$HOME/Projects/go"
    path+=("$GOPATH/bin")
    plugins+=(golang)
fi

local p10k_theme="$HOMEBREW_PREFIX/share/powerlevel10k/powerlevel10k.zsh-theme"
[[ -r "$p10k_theme" ]] && . "$p10k_theme"

export POWERLEVEL9K_CONFIG_FILE="$ZDOTDIR/.p10k.zsh"
[[ -r "$POWERLEVEL9K_CONFIG_FILE" ]] && . "$POWERLEVEL9K_CONFIG_FILE"

. "$ZSH/oh-my-zsh.sh"
