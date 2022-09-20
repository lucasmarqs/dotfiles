Built with [rcm](https://github.com/thoughtbot/rcm)

```sh
rcup -d ~/.dotfiles -x README.md -v
```

## arch setup

```
# deps

yay -S neovim rcm kitty fzf the_silver_searcher ripgrep httpie git-delta asdf-vm

# zsh plugins
zplug install

# asdf deps
# * ruby
# * direnv
# * nodejs
# * python

asdf plugin list all # get all available plugins
asdf plugin add {plugin-name}
asdf install direnv latest
```

## [packer](https://github.com/wbthomason/packer.nvim)

```
git clone --depth 1 https://github.com/wbthomason/packer.nvim\
 ~/.local/share/nvim/site/pack/packer/start/packer.nvim
```
