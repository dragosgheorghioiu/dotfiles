# Download Znap, if it's not there yet.
[[ -r ~/zsh_repos/znap/znap.zsh ]] ||
    git clone --depth 1 -- \
        https://github.com/marlonrichert/zsh-snap.git ~/zsh_repos/znap
source ~/zsh_repos/znap/znap.zsh  # Start Znap

znap prompt sindresorhus/pure

znap source zsh-users/zsh-autosuggestions
znap source zsh-users/zsh-syntax-highlighting
znap source zsh-users/zsh-completions
znap source Aloxaf/fzf-tab

znap source ohmyzsh/ohmyzsh lib/history

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

alias ls='ls --color'
alias neofetch='fastfetch'
eval "$(fzf --zsh)"
eval "$(zoxide init --cmd cd zsh)"

export PATH=$PATH:~/.cargo/bin/:$(go env GOPATH)/bin:~/.ghcup/bin:~/.ghcup/ghc/9.4.8/bin/:~/.config/emacs/bin

if command -v tmux &> /dev/null && [ -z "$TMUX" ]; then
  tmux attach-session -t default || tmux new-session -s default
fi

bindkey -v
