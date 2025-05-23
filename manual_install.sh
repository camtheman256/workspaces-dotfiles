#!/usr/bin/env bash
# ensure you set the executable bit on the file with `chmod u+x install.sh`

# If you remove the .example extension from the file, once your workspace is created and the contents of this
# repo are copied into it, this script will execute.  This will happen in place of the default behavior of the workspace system,
# which is to symlink the dotfiles copied from this repo to the home directory in the workspace.
#
# Why would one use this file in stead of relying upon the default behavior?
#
# Using this file gives you a bit more control over what happens.
# If you want to do something complex in your workspace setup, you can do that here.
# Also, you can use this file to automatically install a certain tool in your workspace, such as vim.
#
# Just in case you still want the default behavior of symlinking the dotfiles to the root,
# we've included a block of code below for your convenience that does just that.

# set -euo pipefail
# 
# DOTFILES_PATH="$HOME/dotfiles"
# 
# # Symlink dotfiles to the root within your workspace
# find $DOTFILES_PATH -type f -path "$DOTFILES_PATH/.*" |
# while read df; do
#   link=${df/$DOTFILES_PATH/$HOME}
#   mkdir -p "$(dirname "$link")"
#   ln -sf "$df" "$link"
# done

# Graphical install for x86 desktops

# sudo apt update
# sudo apt install -y xubuntu-desktop
# 
# wget https://dl.google.com/linux/direct/chrome-remote-desktop_current_amd64.deb
# sudo apt install -y ./chrome-remote-desktop_current_amd64.deb
# rm ./chrome-remote-desktop_current_amd64.deb

# Install gh CLI

(type -p wget >/dev/null || (sudo apt update && sudo apt-get install wget -y)) \
	&& sudo mkdir -p -m 755 /etc/apt/keyrings \
        && out=$(mktemp) && wget -nv -O$out https://cli.github.com/packages/githubcli-archive-keyring.gpg \
        && cat $out | sudo tee /etc/apt/keyrings/githubcli-archive-keyring.gpg > /dev/null \
	&& sudo chmod go+r /etc/apt/keyrings/githubcli-archive-keyring.gpg \
	&& echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
	&& sudo apt update \
	&& sudo apt install gh -y

pip3 install --user setuptools
pip3 install --user git+https://github.com/nvbn/thefuck.git

curl -L --proto '=https' --tlsv1.2 -sSf https://raw.githubusercontent.com/cargo-bins/cargo-binstall/main/install-from-binstall-release.sh | bash
~/.cargo/bin/cargo-binstall -y --strategies crate-meta-data jj-cli

cd ~/dd/dd-source/
rm -rf .git/
jj git init
jj config set --repo snapshot.max-new-file-size 20971520
jj git remote add origin git@github.com:DataDog/dd-source.git
jj git fetch
# jj b t main@origin
