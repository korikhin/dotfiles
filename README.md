# Dotfiles

A script to manage your dotfiles using GNU Stow.

## Usage

```
stow.sh [options] modules/package ...

Options:
    -n               Simulate stowing (dry run)
    --show           Show available packages
    --show-all       Show all packages including hidden ones
    --show-hidden    Show only hidden packages
    -h, --help       Show help message
```

## How It Works

The script follows these rules when stowing packages:

1. Package should be organized as `module/package` (e.g. `shell/zsh`)
2. Each package is processed according to these rules:
   - If the package is in the `misc` module or contains a `.nostow` file, it will be skipped
   - Files are stowed into `$XDG_CONFIG_HOME/package` (defaults to `~/.config/package`)
   - If the package has a `home` directory, its contents are stowed directly into `$HOME`

## Examples

```sh
# Stow zsh configuration
./stow.sh shell/zsh

# Simulate stowing multiple packages
./stow.sh -n shell/bash shell/zsh

# Stow with fzf
./stow.sh $(./stow.sh --show | fzf)
```

## Requirements

- GNU Stow

## Homebrew

Create `Brewfile`:

```sh
brew bundle dump
```

Install all dependencies:

```sh
brew bundle --file=path/to/Brewfile
brew bundle cleanup
```
