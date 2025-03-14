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
zplug "chriskempson/base16-shell", from:github, lazy:off
zplug "romkatv/powerlevel10k", as:theme, depth:1
zplug "zsh-users/zsh-history-substring-search", lazy:off
zplug "zsh-users/zsh-completions", lazy:off
zplug "zsh-users/zsh-autosuggestions", lazy:off
zplug "zsh-users/zsh-syntax-highlighting", lazy:off
zplug "modules/history", from:prezto, lazy:off
zplug "plugins/heroku", from:oh-my-zsh
zplug "skywind3000/z.lua"

if ! zplug check; then
  zplug install
fi

zplug load
# End of zplug's Plugins

# Base16 color themes
# base16_onedark
base16_one-light
# End of base16 color themes

bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down

# heroku
if type brew &>/dev/null
then
  FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"
fi

# The following lines were added by compinstall
zstyle :compinstall filename '/home/lucasmarqs/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# FZF
export FZF_CTRL_T_OPTS="
  --preview 'bat -n --color=always {}'
  --bind 'ctrl-/:change-preview-window(down|hidden|)'"
[[  -f /usr/share/fzf/shell/key-bindings.zsh ]] && source /usr/share/fzf/shell/key-bindings.zsh
[[  -f /opt/homebrew/opt/fzf/shell/key-bindings.zsh ]] && source /opt/homebrew/opt/fzf/shell/key-bindings.zsh
[[ -f /usr/share/fzf/key-bindings.zsh ]] && source /usr/share/fzf/key-bindings.zsh

_fzf_compgen_path() {
  fd --hidden --follow --exclude ".git" . "$1"
}
# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
  fd --type d --hidden --follow --exclude ".git" . "$1"
}

# direnv settings
eval "$(direnv hook zsh)"
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
alias heroku='TERM=xterm-256color heroku'

# GO
export GO111MODULE=on
export GOBIN=$HOME/go/bin
path+=($GOBIN)

# RUST
path+=(/home/lucasmarqs/.cargo/bin)

# JAVA
export JAVA_HOME=/Library/Java/JavaVirtualMachines/openjdk-11.jdk/Contents/Home
path+=($JAVA_HOME/bin)

# Source local configurations
[[ -s "$HOME/.local.zsh" ]] && source "$HOME/.local.zsh"

export DOCKER_HOST='unix:///Users/lusmarques/.colima/default/docker.sock'

# libpq homebrew
path+=(/opt/homebrew/opt/libpq/bin)

# asdf settings
path=("${ASDF_DATA_DIR:-$HOME/.asdf}/shims" $path)
# end of asdf settings

# export to sub-processes
export PATH
