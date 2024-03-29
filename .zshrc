# pure shell 

# path
export PATH=$PATH:$HOME/.cargo/bin/:$HOME/go/bin:~/.local/bin/

# util functions
load_plugin() {
  local plugin_name=$1
  local url_var="${plugin_name}[url]"
  local dir_var="${plugin_name}[dir]"
  local source_file_var="${plugin_name}[source_file]"

  local plugin_dir="$ZSH_PLUGINS_DIR/${(P)dir_var}"
  local full_path="$plugin_dir/${(P)source_file_var}"

  [[ -f $full_path ]] && source "$full_path"
}

setup_plugins() {
  for plugin_name in "${plugins[@]}"; do
    url_var="${plugin_name}[url]"
    source_file_var="${plugin_name}[source_file]"
    dir_var="${plugin_name}[dir]"

    url=${(P)url_var}
    source_file=${(P)source_file_var}
    dir=${(P)dir_var}

    plugin_dir="$ZSH_PLUGINS_DIR/$dir"
    full_path="$plugin_dir/$source_file"

    [[ ! -d $plugin_dir ]] && 
        git clone --depth=1 "$url" "$plugin_dir"
  done
}

# extras
ZSH_EXTRAS_DIR="${XDG_DATA_HOME:-${HOME}/.zsh_extras}"
ZSH_COMPLETIONS_DIR="${ZSH_EXTRAS_DIR}/completions"
ZSH_PLUGINS_DIR="${ZSH_EXTRAS_DIR}/plugins"

[[ ! -d "$ZSH_EXTRAS_DIR" ]] && mkdir -p "$ZSH_EXTRAS_DIR"
[[ ! -d "$ZSH_COMPLETIONS_DIR" ]] && mkdir -p "$ZSH_COMPLETIONS_DIR"
[[ ! -d "$ZSH_PLUGINS_DIR" ]] && mkdir -p "$ZSH_PLUGINS_DIR"

# completions
if (( $+commands[docker] )) && [ ! -f "${ZSH_COMPLETIONS_DIR}/_docker" ]; then
  docker completion zsh > "${ZSH_COMPLETIONS_DIR}/_docker"
fi

autoload -Uz compinit
fpath=("$ZSH_COMPLETIONS_DIR" $fpath)
ZSH_COMPDUMP="${ZDOTDIR:-$HOME}/.zcompdump"

compinit -C

if [[ ! -s "$ZSH_COMPDUMP.zwc" || "$ZSH_COMPDUMP" -nt "$ZSH_COMPDUMP.zwc" ]]; then
  zcompile "$ZSH_COMPDUMP"
fi

# plugins
typeset -A syntax_highlighting=(
  [url]="https://github.com/zdharma-continuum/fast-syntax-highlighting.git"
  [dir]="fast-syntax-highlighting"
  [source_file]="fast-syntax-highlighting.plugin.zsh"
)

typeset -A auto_suggestions=(
  [url]="https://github.com/zsh-users/zsh-autosuggestions.git"
  [dir]="zsh-autosuggestions"
  [source_file]="zsh-autosuggestions.zsh"
)

typeset -a plugins=("syntax_highlighting" "auto_suggestions")

zle-line-init() {
  load_plugin syntax_highlighting
  zle -D zle-line-init
}

zle -N zle-line-init
load_plugin auto_suggestions
bindkey '^Y' autosuggest-accept

# aliases
alias ls='ls --color'
for cmd in v vi vim; do alias $cmd='nvim'; done

# fzf
if (( $+commands[fzf] )); then 
  export FZF_DEFAULT_OPTS="
    --bind 'ctrl-a:toggle-all'
    --bind 'ctrl-d:half-page-down'
    --bind 'ctrl-u:half-page-up'
    --bind 'ctrl-y:accept'
    --height 50%
    --layout reverse
    --color 'pointer:#E8B589,prompt:#6E94B2'
    --prompt 'fzf ❯ '
    --info hidden
  "
fi

# tmux-sessionizer
if (( $+commands[fzf] )); then 
  tmux-sessionizer() {
    if [[ $# -eq 1 ]]; then
        selected=$1
    else
        selected=$(find ~/work ~/projects ~/ ~/personal -mindepth 1 -maxdepth 1 -type d | fzf --reverse)
    fi

    if [[ -z $selected ]]; then
        return
    fi

    selected_name=$(basename "$selected" | tr . _)
    tmux_running=$(pgrep tmux)

    tmux has-session -t="$selected_name" 2>/dev/null
    session_exists=$?

    if [[ -z "$TMUX" ]]; then
        if [[ $session_exists -eq 0 ]]; then
            tmux attach-session -t "$selected_name"
        else
            tmux new-session -s "$selected_name" -c "$selected"
        fi
    else
        if [[ $session_exists -ne 0 ]]; then
            tmux new-session -ds "$selected_name" -c "$selected"
        fi
        tmux switch-client -t "$selected_name"
    fi
  }
  alias ts=tmux-sessionizer
fi

# history
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory

# completions
setopt AUTO_LIST
setopt AUTO_MENU
setopt COMPLETE_IN_WORD
setopt ALWAYS_TO_END
setopt MENU_COMPLETE

zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

# colored completion
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

# group matches
zstyle ':completion:*:*:*:*:*' menu select
zstyle ':completion:*:matches' group 'yes'
zstyle ':completion:*:options' description 'yes'
zstyle ':completion:*:options' auto-description '%d'
zstyle ':completion:*:corrections' format ' %F{green}-- %d (errors: %e) --%f'
zstyle ':completion:*:descriptions' format ' %F{yellow}-- %d --%f'
zstyle ':completion:*:messages' format ' %F{purple} -- %d --%f'
zstyle ':completion:*:warnings' format ' %F{red}-- no matches found --%f'
zstyle ':completion:*:default' list-prompt '%S%M matches%s'
zstyle ':completion:*' format ' %F{yellow}-- %d --%f'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' verbose yes

# caching
zstyle ':completion::complete:*' use-cache on
zstyle ':completion::complete:*' cache-path "${ZDOTDIR:-$HOME}/.zcompcache"

# dirs
zstyle ':completion:*:cd:*' tag-order local-directories directory-stack path-directories
zstyle ':completion:*:*:cd:*:directory-stack' menu yes select
zstyle ':completion:*:-tilde-:*' group-order 'named-directories' 'path-directories' 'users' 'expand'
zstyle ':completion:*' squeeze-slashes true

# history
zstyle ':completion:*:history-words' stop yes
zstyle ':completion:*:history-words' remove-all-dups yes
zstyle ':completion:*:history-words' list false
zstyle ':completion:*:history-words' menu yes

if (( $+commands[fzf] )); then 
  fzf-history-widget() {
    local selected_cmd
    selected_cmd=$(fc -rl 1 | awk '{$1=""; sub(/^ /, ""); print}' | awk '!seen[$0]++' | fzf +s)
    if [[ -n $selected_cmd ]]; then
      BUFFER=$selected_cmd
      CURSOR=${#BUFFER}
    fi
    zle reset-prompt
  }
  zle -N fzf-history-widget
  bindkey '^R' fzf-history-widget
fi

# prompt
export VIRTUAL_ENV_DISABLE_PROMPT=1
setopt PROMPT_SUBST

pending_jobs() {
 [[ $#jobstates -ne 0 ]] && echo '%B%F{magenta}*%f%b'
}

PROMPT='
%F{yellow}%~%f
${VIRTUAL_ENV:+"($(basename $VIRTUAL_ENV)) "}$(pending_jobs)%(?.%F{blue}.%F{red})❯%f '

PROMPT2='%F{242}...%f '
