ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"

zinit light zsh-users/zsh-autosuggestions
zinit light zdharma-continuum/fast-syntax-highlighting
zinit ice wait lucid atload'_zsh_autosuggest_start'
zinit light zsh-users/zsh-autosuggestions

zinit ice pick"async.zsh" src"pure.zsh"
zinit light sindresorhus/pure

alias ls='ls --color'
alias neofetch='fastfetch'
alias v='nvim'

eval "$(fzf --zsh)"
eval "$(zoxide init --cmd cd zsh)"

autoload -Uz compinit
zcompdump="${ZDOTDIR:-$HOME}/.zcompdump"
if [[ (! -f "$zcompdump" || "$zcompdump" -ot "$ZSHRC") ]]; then
    compinit
else
    compinit -C
fi

export PATH=$PATH:~/.cargo/bin/:$(go env GOPATH)/bin:~/.local/bin/

bindkey -v
