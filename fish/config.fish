if status is-interactive
    # Commands to run in interactive sessions can go here
end

alias vim=nvim
alias ls="lsd --group-dirs first"
# fish_vi_key_bindings

# pnpm
set -gx PNPM_HOME "/Users/macbook/Library/pnpm"
if not string match -q -- $PNPM_HOME $PATH
  set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end

# fzf
# function fzf --wraps="fzf"
#     set -Ux FZF_DEFAULT_OPTS "
#     --color=fg:#908caa,bg:#191724,hl:#ebbcba
#     --color=fg+:#e0def4,bg+:#26233a,hl+:#ebbcba
#     --color=border:#403d52,header:#31748f,gutter:#191724
#     --color=spinner:#f6c177,info:#9ccfd8,separator:#403d52
#     --color=pointer:#c4a7e7,marker:#eb6f92,prompt:#908caa
#   "
#     command fzf
# end
set fzf_directory_opts --bind "ctrl-o:execute($EDITOR {} &> /dev/tty)"
fzf_configure_bindings --directory=\cf --history=\cy
#fzf end

set --export PATH /usr/local/opt/llvm/bin $PATH
set --export LDFLAGS -L/usr/local/opt/llvm/lib

set --export PATH $HOME/.cargo/bin $PATH
set -Ux BAT_THEME TwoDark

set --export LC_ALL en_US.UTF-8  
set --export LANG en_US.UTF-8

set -gx $EDITOR "nvim"

set fish_greeting ""

