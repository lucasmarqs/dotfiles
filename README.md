# Dotfiles

Built with [rcm](https://github.com/thoughtbot/rcm).

## Getting Started

1. **Install required dependency by hand:**
   - [Homebrew](https://brew.sh/)

2. **Link dotfiles:**
   Clone this repo to `~/.dotfiles`, then run:
   ```sh
   brew install rcm
   rcup -d ~/.dotfiles -x README.md -v
   ```

3. **Install everything else:**
   ```sh
   cd ~/.dotfiles
   brew bundle
   ```

## What else you need to know

- **Zsh Plugins:** Handled automatically by `zplug` upon starting your shell for the first time.
- **Language Runtimes:** Managed via `asdf`. You will need to install the plugins and runtimes manually (e.g., `ruby`, `nodejs`, `python`):
  ```sh
  asdf plugin add ruby
  asdf plugin add nodejs
  asdf plugin add python
  # Then install your preferred versions
  ```
- **Included Configurations:** Includes configurations for Neovim, Alacritty, Zellij, and Git.
