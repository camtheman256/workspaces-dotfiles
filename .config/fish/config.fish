if status is-interactive
    # Commands to run in interactive sessions can go here
end

eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

fish_add_path -m ~/.local/bin
ddr completion fish | source
direnv hook fish | source
COMPLETE=fish jj | source
set -gx VOLTA_HOME "$HOME/.volta"
set -gx PATH "$VOLTA_HOME/bin" $PATH

# Added by Yarn Switch
source "/home/bits/.yarn/switch/env.fish"
