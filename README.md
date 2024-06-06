Built with [rcm](https://github.com/thoughtbot/rcm)

```sh
rcup -d ~/.dotfiles -x README.md -v
```

## macos setup

```sh
# get Brew from https://brew.sh/ then
cd .dotfiles
brew bundle
```

## arch setup

```
# deps

yay -S base-devel neovim rcm kitty fzf the_silver_searcher ripgrep httpie git-delta asdf-vm

# zsh plugins
zplug install

```

## asdf

# * direnv
# * ruby
# * nodejs
# * python

asdf manages direnv:

```sh
asdf plugin add direnv
asdf install direnv latest
asdf global direnv $DIRENV_VERSION_INSTALLED
asdf direnv setup --shell zsh --version $DIRENV_VERSION_INSTALLED
```

## [packer](https://github.com/wbthomason/packer.nvim)

```
git clone --depth 1 https://github.com/wbthomason/packer.nvim\
 ~/.local/share/nvim/site/pack/packer/start/packer.nvim
```
