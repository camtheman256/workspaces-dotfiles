if status is-interactive
    # Commands to run in interactive sessions can go here
end

eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

fish_add_path -m ~/.local/bin
ddr completion fish | source
direnv hook fish | source
COMPLETE=fish jj | source
