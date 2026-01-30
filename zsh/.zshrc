# Set the directory we want to store zinit and plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Download Zinit, if it's not there yet
if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname "$ZINIT_HOME")"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Source/Load zinit
source "${ZINIT_HOME}/zinit.zsh"

# Add in zsh plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab
zinit light romkatv/zsh-defer

# Load completions
autoload -Uz compinit && compinit

# Completion styling
zstyle ':completion:*' verbose yes
zstyle ':completion:*:descriptions' format '[%d]'
zstyle ':completion:*' group-name ''
zstyle ':completion:*:default' list-prompt '%S%M matches%s'
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':fzf-tab:*' switch-group ',' '.'
zstyle ':fzf-tab:*' fzf-flags \
  --height=40% \
  --layout=reverse \
  --info=inline \
  --border \
  --prompt='❯ '
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'lsd --color=always --icon=always --tree --depth=1 $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'lsd --color=always --icon=always --tree --depth=1 $realpath'


# History
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory sharehistory hist_ignore_space hist_ignore_all_dups \
       hist_save_no_dups hist_ignore_dups hist_find_no_dups

# Editor
export EDITOR="nvim"

#Apache Maven + Tomcat
export CATALINA_HOME=/home/rik/apache-tomcat-9.0.80
export PATH=$CATALINA_HOME/bin:$PATH

# PATH
export PATH=$HOME/.config/rofi/scripts:$PATH
export PATH="/usr/local/sbin:/usr/local/bin:/usr/bin:/usr/sbin:/bin:/sbin:$HOME/.config/rofi/scripts:$HOME/.local/share/zinit/polaris/bin:/var/lib/snapd/snap/bin"

# GO
export PATH=$PATH:/usr/local/go/bin

export PATH="$HOME/.composer/vendor/bin:$PATH"
export PATH=$HOME/.local/bin:$PATH
# Shell integrations
eval "$(fzf --zsh)"
eval "$(zoxide init --cmd cd zsh)"

# Keybindings
bindkey "^[[A" history-search-backward
bindkey "^[[B" history-search-forward

# Aliases
alias l="eza -a --icons=always"
alias ll="eza --color=always --long --git --no-filesize --icons=always --no-time --no-user --no-permissions"
alias lll="eza --color=always --long --icons=always"
alias ltree="eza --color=always --icons=always --tree"
alias bat='bat --style=numbers,changes --theme=OneHalfDark'
alias d='pwd'
alias szsh='source ~/.zshrc && echo "🔁 Zsh reloaded!"'
alias zoxidecc='zoxide query -l | fzf | xargs -r cd'
alias vi="nvim"
alias vim="nvim"
alias f='fzf --preview "bat --color=always --style=numbers {}"'
# alias fd='cd "$(find . -type d | fzf)"'
alias ff='rg --files | fzf --preview "bat --style=numbers --color=always {}"'
alias fgr='rg --line-number --no-heading . | fzf --delimiter : --preview "bat --color=always {1} --highlight-line {2}"'
alias lgit='lazygit'
alias mountdisk="sudo mount -t ntfs-3g /dev/sda1 /mnt/external_drive"
alias please='sudo'
alias matrix="cmatrix -b -u 2"

# XAMPP STuff

# DOCKER oracle
alias oracle-start='sudo docker start -ai oracle23ai'
alias oracle-stop='sudo docker stop oracle23ai'
alias oracle-status="sudo docker ps --filter 'name=oracle23ai'"
alias oracle-logs='sudo docker logs -f oracle23ai'

# Docker mysql
alias mysql-start='docker start mysql8'
alias mysql-stop='docker stop mysql8'

# Fzf functions
nvim-fzf() {
  local file
  file=$(fzf --preview "bat --color=always --style=numbers {}")
  [ -n "$file" ] && nvim "$file"
}

nvim-fzf-d() {
  local file
  file=$(fc -l | fzf)
  [ -n "$file" ] && eval "$file"
}

jj() {
  local dir
  dir=$(find . -type d 2>/dev/null | fzf --preview "lsd -lA --color=always {}")
  [ -n "$dir" ] && cd "$dir"
}

function y() {
  local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
  yazi "$@" --cwd-file="$tmp"
  if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
    builtin cd -- "$cwd"
  fi
  rm -f -- "$tmp"
}

# EDIT Command
autoload -z edit-command-line
zle -N edit-command-line
bindkey "^x^e" edit-command-line

# The Fuck 
eval $(thefuck --alias)
eval $(thefuck --alias fk)


# Starship prompt
export STARSHIP_CONFIG="$HOME/.config/starship.toml"
eval "$(starship init zsh)"


fastfetch --config examples/13
