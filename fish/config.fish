# -- env
set --export XDG_CONFIG_HOME $HOME/.config
set --export XDG_CACHE_HOME $HOME/.cache
set --export XDG_DATA_HOME $HOME/.local/share
set --export XDG_STATE_HOME $HOME/.local/state
set --export BAT_THEME ansi
set --export LC_ALL en_US.UTF-8  
set --export LANG en_US.UTF-8
set --export EDITOR "nvim"
set --export VISUAL "nvim"

# -- aliases
alias vim=nvim
alias ls="lsd --group-dirs first"
alias qview="/Applications/qView.app/Contents/MacOS/qView"
alias clean-ds="fd '.DS_Store' ~ --type f --hidden --no-ignore -X rm"
set fish_prompt_pwd_dir_length 3

# -- vi mode
fish_hybrid_key_bindings
function fish_mode_prompt
end
bind yy fish_clipboard_copy
bind Y fish_clipboard_copy
bind p fish_clipboard_paste

# -- pnpm
set -gx PNPM_HOME "/Users/macbook/Library/pnpm"
if not string match -q -- $PNPM_HOME $PATH
  set -gx PATH "$PNPM_HOME" $PATH
end

# -- fzf
set -Ux FZF_DEFAULT_OPTS "
    --color=fg:#cecece,bg:-1,hl:#d2322d
    --color=fg+:#cecece,bg+:-1,hl+:#95cb82
    --color=border:#333333,header:#2384C4,gutter:#181818
    --color=spinner:#cd974b,info:#9ccfd8,separator:#333333
    --color=pointer:#dfdf8e,marker:#9B3596,prompt:#cecece
  "

fzf_configure_bindings --directory=\ct

# -- custom bindings
function vm
  set files (fd --type f \
    --exclude node_modules \
    --exclude .next \
    --exclude .nx \
    --exclude dist \
    --exclude build \
    | fzf -m --preview="bat --color=always {}")
  if test -n "$files"
    vim $files
  end
end

function yarn
    command yarn --use-yarnrc "$XDG_CONFIG_HOME/yarn/config" $argv
end

function mem
    if test (count $argv) -eq 0
        echo "Usage: mem <Program name>"
        return 1
    end

    set program $argv[1]

    ps -ax -o rss,comm | grep -i "$program" | awk '{sum += $1} END {print sum/1024 " MB"}'
end

function yt-search
  set input (echo | fzf --print-query --prompt='YouTube Search: ' --no-select-1 --no-sort)
  if test -z "$input"
    echo "No query entered"
    return 1
  end

  set words (string split ' ' -- $input)
  set last $words[-1]

  if string match -qr '^\d+$' -- $last
    set count $last
    set query $words[1..-2]
  else
    set count 20
    set query $words
  end

  set query_str (string join ' ' $query)

  set selected (~/scripts/fetch-yt.js "$query_str" $count \
    | fzf --prompt='Pick video: ' --ansi --sync \
      --preview='
        set video_id (echo {} | awk -F "\t" "{print \$3}")
        kitty icat --clear --transfer-mode=memory --stdin=no --scale-up --place={$FZF_PREVIEW_COLUMNS}x{$FZF_PREVIEW_LINES}@0x0 https://img.youtube.com/vi/$video_id/hqdefault.jpg
      ')

  if test -n "$selected"
    set video_id (echo $selected | awk -F '\t' '{print $3}')
    set url "https://youtube.com/watch?v=$video_id"
    iina $url --mpv-fs
  end
end

# -- xdg dotfiles
set --export NPM_CONFIG_USERCONFIG $XDG_CONFIG_HOME/npm/npmrc
set --export GNUPGHOME $XDG_DATA_HOME/gnupg
set --export AWS_SHARED_CREDENTIALS_FILE $XDG_CONFIG_HOME/aws/credentials
set --export AWS_CONFIG_FILE $XDG_CONFIG_HOME/aws/config
set --export WGETRC $XDG_CONFIG_HOME/wget/wgetrc
set --export LESSHISTFILE $XDG_CACHE_HOME/lesshst
set --export SQLITE_HISTORY $XDG_STATE_HOME/sqlite_history
set --export PSQL_HISTORY $XDG_STATE_HOME/psql_history
set --export NODE_REPL_HISTORY $XDG_DATA_HOME/node_repl_history
set --export PYTHON_HISTORY $XDG_STATE_HOME/python_history
set --export TEXMFHOME $XDG_DATA_HOME/texmf
set --export TEXMFVAR $XDG_CACHE_HOME/texlive/texmf-var
set --export TEXMFCONFIG $XDG_CONFIG_HOME/texlive/texmf-config
set --export WINEPREFIX $XDG_DATA_HOME/wineprefixes/default
set --export RUSTUP_HOME $XDG_DATA_HOME/rustup
set --export PYENV_ROOT $XDG_DATA_HOME/pyenv
set --export PRETTIERD_SOCKET_DIR $XDG_CACHE_HOME/prettierd
set --export OMNISHARPHOME $XDG_CONFIG_HOME/omnisharp 
set --export OLLAMA_MODELS $XDG_DATA_HOME/ollama/models
set --export NUGET_PACKAGES $XDG_CACHE_HOME/NuGetPackages
set --export MPLCONFIGDIR $XDG_CONFIG_HOME/matplotlib
set --export GRADLE_USER_HOME $XDG_DATA_HOME/gradle
set --export DOCKER_CONFIG $XDG_CONFIG_HOME/docker
set --export DEGIT_CACHE $XDG_CACHE_HOME/degit
set --export CARGO_HOME $XDG_DATA_HOME/cargo
set --export RIPGREP_CONFIG_PATH $XDG_CONFIG_HOME/ripgrep/ripgreprc

# -- path
set --export PATH $HOME/.dotnet/tools $PATH
set --export PATH $CARGO_HOME/bin $PATH
set --export PATH $XDG_CACHE_HOME/go/bin $PATH
set --export PATH $HOME/scripts $PATH
set --export PATH $HOME/.local/bin $PATH

# -- tmp
set --export PATH $HOME/tmp/cmus/usr/local/bin $PATH

set fish_greeting ""

zoxide init fish | source
