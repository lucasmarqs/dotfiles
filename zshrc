export EDITOR=nvim
bindkey -v

# Homebrew configuration for MacOS
if (( ! $+commands[brew] )); then
  BREW_LOCATION='/opt/homebrew/bin/brew'
  if [[ -x $BREW_LOCATION ]]; then
    eval "$("$BREW_LOCATION" shellenv)"
  fi
  unset BREW_LOCATION
fi

# zplug settings
export ZPLUG_HOME="$HOME/.zplug"
if [ ! -d "$ZPLUG_HOME" ]; then
  echo "Installing zplug..."
  git clone https://github.com/zplug/zplug $ZPLUG_HOME
fi
. $ZPLUG_HOME/init.zsh
# end of zplug settings


# List of zplug's Plugins
zplug "chriskempson/base16-shell", from:github
zplug "romkatv/powerlevel10k", as:theme, depth:1
zplug "zsh-users/zsh-history-substring-search"
zplug "zsh-users/zsh-completions"
zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-syntax-highlighting", defer:2
zplug "modules/history", from:prezto
zplug "plugins/asdf", from:oh-my-zsh

zplug load
# End of zplug's Plugins

# Base16 color themes
base16_onedark
# End of base16 color themes

bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down

# The following lines were added by compinstall
zstyle :compinstall filename '/home/lucasmarqs/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# FZF
export FZF_DEFAULT_COMMAND='fd --type f --hidden --exclude .git'
[[  -f /usr/share/fzf/shell/key-bindings.zsh ]] && source /usr/share/fzf/shell/key-bindings.zsh
[[  -f /opt/homebrew/opt/fzf/shell/key-bindings.zsh ]] && source /opt/homebrew/opt/fzf/shell/key-bindings.zsh
[[ -f /usr/share/fzf/key-bindings.zsh ]] && source /usr/share/fzf/key-bindings.zsh

# direnv settings
eval "$(asdf exec direnv hook zsh)"
direnv() { asdf exec direnv "$@"; }
# end of direnv settings

# Aliases
alias g='git'
alias rbbe='bundle exec'
alias dockerc='docker-compose'
if (( $+commands[xdg-open] )); then
  alias o'=xdg-open'
else
  alias o='open'
fi

# GO
export GO111MODULE=on
export GOBIN=$HOME/go/bin
path+=($GOBIN)

# RUST
path+=(/home/lucasmarqs/.cargo/bin)

# export to sub-processes
export PATH

# Source local configurations
[[ -s "$HOME/.local.zsh" ]] && source "$HOME/.local.zsh"
source "${XDG_CONFIG_HOME:-$HOME/.config}/asdf-direnv/zshrc"
