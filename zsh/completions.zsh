autoload -Uz compinit; compinit
zmodload -i zsh/complist
setopt auto_menu complete_in_word
bindkey '^E' expand-or-complete
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}' 'r:|[._-]=* r:|=*'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
