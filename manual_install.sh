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

sudo apt update
sudo apt install -y ubuntu-desktop

wget https://dl.google.com/linux/direct/chrome-remote-desktop_current_amd64.deb
sudo apt install -y ./chrome-remote-desktop_current_amd64.deb
rm ./chrome-remote-desktop_current_amd64.deb

pip3 install --user git+https://github.com/nvbn/thefuck.git

curl -L --proto '=https' --tlsv1.2 -sSf https://raw.githubusercontent.com/cargo-bins/cargo-binstall/main/install-from-binstall-release.sh | bash
~/.cargo/bin/cargo-binstall --strategies crate-meta-data jj-cli

rm -rf ~/dd/dd-source/.git/
jj -R ~/dd/dd-source/ git init
jj -R ~/dd/dd-source/ git remote add origin git@github.com:DataDog/dd-source.git
jj -R ~/dd/dd-source/ git fetch
jj -R ~/dd/dd-source/ git b t main@origin
