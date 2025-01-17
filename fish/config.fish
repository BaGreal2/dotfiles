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

set --export NODE_OPTIONS "--max-old-space-size=16384"
set --export TSC_NONPOLLING_WATCHER true

set -Ux BAT_THEME Nord

set --export LC_ALL en_US.UTF-8  
set --export LANG en_US.UTF-8

set -gx $EDITOR "nvim"

set fish_greeting ""

zoxide init fish | source


# Created by `pipx` on 2025-01-02 00:32:07
set PATH $PATH /Users/xanin/.local/bin
