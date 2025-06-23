# === ORTAM ===
export LANG="en_US.UTF-8"
export EDITOR="nvim"
export PATH="$HOME/.local/bin:$HOME/go/bin:$HOME/.cargo/bin:$PATH"

# === EĞER GEREKLİYSE EKLENTİLERİ İNDİR ===
ZSH_PLUGIN_DIR="$HOME/.zsh"

if [ ! -d "$ZSH_PLUGIN_DIR/zsh-autosuggestions" ]; then
  echo "🔧 zsh-autosuggestions indiriliyor..."
  git clone https://github.com/zsh-users/zsh-autosuggestions "$ZSH_PLUGIN_DIR/zsh-autosuggestions"
fi

if [ ! -d "$ZSH_PLUGIN_DIR/zsh-syntax-highlighting" ]; then
  echo "🔧 zsh-syntax-highlighting indiriliyor..."
  git clone https://github.com/zsh-users/zsh-syntax-highlighting "$ZSH_PLUGIN_DIR/zsh-syntax-highlighting"
fi


# Git completions kontrol & indirme
if [ ! -f "$ZSH_PLUGIN_DIR/git-completion.bash" ] || [ ! -f "$ZSH_PLUGIN_DIR/_git" ]; then
  curl -fsSL -o "$ZSH_PLUGIN_DIR/git-completion.bash" https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash
  curl -fsSL -o "$ZSH_PLUGIN_DIR/_git" https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.zsh
fi


# === PLUGINLER ===
source "$ZSH_PLUGIN_DIR/zsh-autosuggestions/zsh-autosuggestions.zsh"
source "$ZSH_PLUGIN_DIR/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
source "$ZSH_PLUGIN_DIR/git-completion.bash"

# === ZSH AYARLARI ===
setopt autocd              # klasör adı yazınca cd
setopt correct             # yazım düzelt
setopt interactivecomments
setopt append_history
setopt hist_ignore_dups
setopt share_history
setopt extended_glob
setopt globdots

HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history

# === COMPLATE ===
fpath=("$ZSH_PLUGIN_DIR" $fpath)
autoload -Uz compinit && compinit
autoload -Uz bashcompinit && bashcompinit

zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

# === BINDKEY ===
bindkey -e
bindkey '^[[Z' reverse-menu-complete

# === PROMPT ===
autoload -Uz vcs_info
precmd() { vcs_info }

autoload -U colors && colors
zstyle ':vcs_info:git:*' formats '(%b)'
zstyle ':vcs_info:*' enable git

PROMPT='%{$fg[cyan]%}${vcs_info_msg_0_}%{$reset_color%}%{$fg[green]%}%1~ > %{$reset_color%}'



# Pacman / yay
[[ -f /usr/share/bash-completion/completions/pacman ]] && source /usr/share/bash-completion/completions/pacman
[[ -f /usr/share/bash-completion/completions/yay ]] && source /usr/share/bash-completion/completions/yay

# apt / apt-get / apt-cache
for cmd in apt apt-get apt-cache; do
  [[ -f "/usr/share/bash-completion/completions/$cmd" ]] && source "/usr/share/bash-completion/completions/$cmd"
done

# Rust
[[ -s "$HOME/.cargo/env" ]] && source "$HOME/.cargo/env"

# === ALIAS ===
alias ll='ls -lah'
alias gs='git status'
alias ..='cd ..'
alias ...='cd ../..'
alias v='nvim'
alias c='clear'

eval "$(starship init zsh)"
eval "$(zoxide init zsh)"
# Set up fzf key bindings and fuzzy completion
source <(fzf --zsh)


