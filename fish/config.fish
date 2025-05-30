alias vim=nvim
alias ls="lsd --group-dirs first"
# fish_vi_key_bindings
# bind -M insert \ce accept-autosuggestion
# fish_hybrid_key_bindings
set fish_prompt_pwd_dir_length 3

# PNPM START
set -gx PNPM_HOME "/Users/macbook/Library/pnpm"
if not string match -q -- $PNPM_HOME $PATH
  set -gx PATH "$PNPM_HOME" $PATH
end
# PNPM END

# FZF START
set -Ux FZF_DEFAULT_OPTS "
    --color=fg:#cecece,bg:#181818,hl:#d2322d
    --color=fg+:#cecece,bg+:#293334,hl+:#95cb82
    --color=border:#333333,header:#2384C4,gutter:#181818
    --color=spinner:#cd974b,info:#9ccfd8,separator:#333333
    --color=pointer:#dfdf8e,marker:#9B3596,prompt:#cecece
  "


# set fzf_directory_opts --bind "ctrl-o:execute($EDITOR {} &> /dev/tty)"
# fzf_configure_bindings --directory=\cf --history=\cy
# alias vm="vim $(fzf)"
# bind \cf "vim $(fzf)"

set -Ux FZF_ALT_C_OPTS "--preview 'tree -C {}'"

set -Ux FZF_CTRL_R_OPTS "
  --preview 'echo {}' --preview-window up:3:hidden:wrap
  --bind 'ctrl-/:toggle-preview'
  --bind 'ctrl-y:execute-silent(echo -n {2..} | pbcopy)+abort'
  --color header:italic
  --header 'Press CTRL-Y to copy command into clipboard'"

set -Ux FZF_CTRL_T_OPTS "
  --preview 'bat -n --color=always {}'
  --bind 'ctrl-/:change-preview-window(down|hidden|)'"

function vm
  vim $(fzf -m --preview="bat --color=always {}")
end
# FZF END

function mem
    if test (count $argv) -eq 0
        echo "Usage: mem <Program name>"
        return 1
    end

    set program $argv[1]

    # Sum memory for all processes with the program name in their command path
    ps -ax -o rss,comm | grep -i "$program" | awk '{sum += $1} END {print sum/1024 " MB"}'
end

# set --export PATH /usr/local/opt/llvm/bin $PATH
set --export LDFLAGS -L/usr/local/opt/llvm/lib

set --export PATH $HOME/.dotnet/tools $PATH

set --export PATH $HOME/.cargo/bin $PATH

set --export PATH $HOME/go/bin $PATH

# set --export NODE_OPTIONS "--max-old-space-size=16384"
# set --export TSC_NONPOLLING_WATCHER true

set -Ux BAT_THEME Nord

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

  set selected (~/.scripts/fetch-yt.js "$query_str" $count \
    | fzf --prompt='Pick video: ' --ansi --sync \
      --preview='
        set video_id (echo {} | awk -F "\t" "{print \$3}")
        kitty icat --clear --transfer-mode=memory --stdin=no --place={$FZF_PREVIEW_COLUMNS}x{$FZF_PREVIEW_LINES}@0x0 https://img.youtube.com/vi/$video_id/hqdefault.jpg
      ')

  if test -n "$selected"
    set video_id (echo $selected | awk -F '\t' '{print $3}')
    set url "https://youtube.com/watch?v=$video_id"
    iina $url --mpv-fs
  end
end

bind \cy "~/.scripts/yt-search.sh"

set --export LC_ALL en_US.UTF-8  
set --export LANG en_US.UTF-8

set --export EDITOR "nvim"
set --export VISUAL "nvim"

set fish_greeting ""

zoxide init fish | source
