if status is-interactive
    # Commands to run in interactive sessions can go here
end

alias vim=nvim
alias ls="lsd --group-dirs first"

# pnpm
set -gx PNPM_HOME "/Users/macbook/Library/pnpm"
if not string match -q -- $PNPM_HOME $PATH
  set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end
set --export PATH /usr/local/opt/llvm/bin $PATH
set --export LDFLAGS -L/usr/local/opt/llvm/lib

set --export PATH $HOME/.cargo/bin $PATH

set fish_greeting ""
