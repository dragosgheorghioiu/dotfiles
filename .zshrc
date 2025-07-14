# pure shell 
# util functions
load_plugins() {
  # check if can reach github
  if ping -c 1 -W 1 github.com >/dev/null 2>&1; then
    github_up=true
  else
    github_up=false
  fi

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
      [[ $github_up == true ]] && 
        git clone --depth=1 "$url" "$plugin_dir"

    [[ -f $full_path ]] && {
      if [[ $plugin_name == syntax_highlighting ]]; then
        source "$full_path"
      else
        source "$full_path" &!
      fi
    }
  done
}

pwd_details() {
  echo "%F{yellow}%~%f"
}

# extras
ZSH_EXTRAS_DIR="${XDG_DATA_HOME:-${HOME}/.zsh_extras}"
ZSH_COMPLETIONS_DIR="${ZSH_EXTRAS_DIR}/completions"
ZSH_PLUGINS_DIR="${ZSH_EXTRAS_DIR}/plugins"

[[ ! -d "$ZSH_EXTRAS_DIR" ]] && mkdir -p "$ZSH_EXTRAS_DIR"
[[ ! -d "$ZSH_COMPLETIONS_DIR" ]] && mkdir -p "$ZSH_COMPLETIONS_DIR"
[[ ! -d "$ZSH_PLUGINS_DIR" ]] && mkdir -p "$ZSH_PLUGINS_DIR"

# completions
if command -v docker >/dev/null 2>&1 && [ ! -f "${ZSH_COMPLETIONS_DIR}/_docker" ]; then
  docker completion zsh > "${ZSH_COMPLETIONS_DIR}/_docker"
fi

fpath=("$ZSH_COMPLETIONS_DIR" $fpath)
autoload -Uz compinit && compinit

# plugins
typeset -A syntax_highlighting=(
  url "https://github.com/zdharma-continuum/fast-syntax-highlighting.git"
  dir "fast-syntax-highlighting"
  source_file "fast-syntax-highlighting.plugin.zsh"
)

typeset -A auto_suggestions=(
  url "https://github.com/zsh-users/zsh-autosuggestions.git"
  dir "zsh-autosuggestions"
  source_file "zsh-autosuggestions.zsh"
)

plugins=(syntax_highlighting auto_suggestions)

load_plugins

# aliases
alias ls='ls --color'
alias v='nvim'
alias vi='nvim'
alias vim='nvim'

# fzf integration
eval "$(fzf --zsh)"

# TODO: replace with tmux sessionizer
eval "$(zoxide init --cmd cd zsh)"

# history
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory

# path
export PATH=$PATH:~/.cargo/bin/:$(go env GOPATH)/bin:~/.local/bin/

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

# prompt
setopt PROMPT_SUBST

PROMPT='
$(pwd_details)
%(?.%F{blue}.%F{red})❯%f '

PROMPT2='%F{242}...%f '

if [[ -n $SSH_CONNECTION ]]; then
    PROMPT='%F{242}%n@%m%f $(pure_prompt)
$(arrow) '
fi

