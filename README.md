# dotfiles
dotfiles for arch linux

# overview
 - shell: zsh
 - text editor: neovim
 - code search: ag (the silver searcher)
 - fuzzy finder: fzf
 - file manager: ranger
 - terminal emulator: termite
 - window manager: sway
 - status bar: i3blocks
 - notifications: mako

Sway doesn't work well with Nvidia, so on my desktop I use the following instead:
 - window manager: i3-gaps
 - notifications: dunst

See package files for details.

Also, my .gitconfig includes aliases that make some common git commands (add, checkout, diff, reset) interactive, using fzf.

# setup
Arch files are found in the `arch/` directory. run commands in `arch/setup.sh` one at a time to install. the script isn't really automated and some commands will not work as provided.

Within `arch/` are subdirectories for specific computers (core/desktop/laptop). Each directory may contain `pacman-packages.txt` and/or `aur-packages.txt`. See `setup.txt` for an example of how these files are used.
Each arch subdirectory also contains a `link.sh`, which symlinks the files for the corresponding setup. Additional manual setup may be required.
