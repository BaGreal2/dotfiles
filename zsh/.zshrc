# aliases
alias vim='nvim'
alias ls='gls --color=always -ph --group-directories-first'
alias ll='ls -l'
alias la='ls -la'
alias qview='/Applications/qView.app/Contents/MacOS/qView'
alias clean-ds="fd '.DS_Store' ~ --type f --hidden --no-ignore -X rm"
alias ytv='yt-dlp -f "bv*[ext=mp4]+ba[ext=m4a]/b[ext=mp4]/best" -o "$HOME/videos/tmp/%(title)s.%(ext)s"'
alias yta='yt-dlp -f "bestaudio" --extract-audio --audio-format mp3 --audio-quality 0 --add-metadata --parse-metadata "artist:%(uploader)s" -o "$HOME/music/xanin/tmp/%(title)s.%(ext)s"'

# base
PROMPT_DIRTRIM=3
bindkey -v
bindkey '^P' up-line-or-history
bindkey '^N' down-line-or-history
autoload -Uz edit-command-line
zle -N edit-command-line
bindkey -M vicmd 'v' edit-command-line

# fzf
export FZF_DEFAULT_OPTS=$'
    --color=fg:#cecece,bg:-1,hl:#d2322d
    --color=fg+:#cecece,bg+:-1,hl+:#95cb82
    --color=border:#333333,header:#2384C4,gutter:#121212
    --color=spinner:#cd974b,info:#9ccfd8,separator:#333333
    --color=pointer:#dfdf8e,marker:#9B3596,prompt:#cecece
'

# functions
vm() {
  local -a files
  files=(${(f)"$(fd --type f \
    --exclude node_modules \
    --exclude .next \
    --exclude .nx \
    --exclude dist \
    --exclude build \
    | fzf -m --preview='bat --color=always {}')"})
  (( ${#files[@]} )) && vim "${files[@]}"
}

yarn() {
  command yarn --use-yarnrc "$XDG_CONFIG_HOME/yarn/config" "$@"
}

fzf-history-insert() {
  local sel left=$LBUFFER right=$RBUFFER
  sel=$(builtin fc -nrl 1 | fzf --no-sort --query="$LBUFFER") || return
  BUFFER="$left$sel$right"
  CURSOR=$(( ${#left} + ${#sel} ))
  zle redisplay
}
zle -N fzf-history-insert
bindkey -M viins '^R' fzf-history-insert
bindkey -M vicmd '^R' fzf-history-insert
bindkey -M emacs '^R' fzf-history-insert

# sources
source "$ZDOTDIR/prompt.zsh"
source "$ZDOTDIR/completions.zsh"

# eval "$(zoxide init zsh)"
