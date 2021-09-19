export EDITOR=nvim
bindkey -v

# Base16 color themes
BASE16_SHELL="$HOME/.config/base16-shell/"
if [ ! -d $BASE16_SHELL ]; then
  echo "Installing base16-shell colors"
  git clone https://github.com/chriskempson/base16-shell.git $BASE16_SHELL
fi
[ -n "$PS1" ] && [ -s "$BASE16_SHELL/profile_helper.sh" ] && \
  eval "$("$BASE16_SHELL/profile_helper.sh")"
base16_solarflare

# End of base16 color themes

# zplug settings
export ZPLUG_HOME="$HOME/.zplug"
if [ ! -d "$ZPLUG_HOME" ]; then
  echo "Installing zplug..."
  git clone https://github.com/zplug/zplug $ZPLUG_HOME
fi
. $ZPLUG_HOME/init.zsh
# end of zplug settings


# List of zplug's Plugins
zplug "romkatv/powerlevel10k", as:theme, depth:1
zplug "zsh-users/zsh-history-substring-search"
zplug "zsh-users/zsh-completions"
zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-syntax-highlighting", defer:2
zplug "modules/history", from:prezto


zplug load
# End of zplug's Plugins

bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down

# asdf settings
if [ ! -d "$HOME/.asdf" ]; then
  echo "Installing asdf..."
  git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.8.0
fi
. $HOME/.asdf/asdf.sh
fpath=(${ASDF_DIR}/completions $fpath)
# end of asdf settings


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

# direnv settings
eval "$(asdf exec direnv hook zsh)"
direnv() { asdf exec direnv "$@"; }
# end of direnv settings

# k8s
# if { (( ! $+commands[kubectl] )) }
# then
#   cat <<-EOF
#     warning: kubectl is not installed

#     follow the instructions:
#     sudo dnf config-manager --add-repo https://packages.cloud.google.com/yum/repos/kubernetes-el7-x86_64
#     sudo rpm --import \
#       https://packages.cloud.google.com/yum/doc/yum-key.gpg \
#       https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg
#     sudo dnf install kubectl
#   EOF
# fi


export KREW_ROOT=$HOME/.krew
path+=($KREW_ROOT/bin)
# end of k8s

# Aliases
alias g='git'
alias rbbe='bundle exec'
alias dockerc='docker-compose'

# GO
export GO111MODULE=on
export GOBIN=$HOME/go/bin
path+=($GOBIN)

# RUST
path+=(/home/lucasmarqs/.cargo/bin)

# export to sub-processes
export PATH

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/home/lucasmarqs/.sdkman"
if [[ ! -d ${SDKMAN_DIR} ]]; then
  curl -s "https://get.sdkman.io" | bash
fi
[[ -s "/home/lucasmarqs/.sdkman/bin/sdkman-init.sh" ]] && source "/home/lucasmarqs/.sdkman/bin/sdkman-init.sh"

# Source local configurations
[[ -s "~/.local.zsh" ]] && source "~/.local.zsh" ]]
