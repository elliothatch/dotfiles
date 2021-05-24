# dotfiles
configuration and scripts for arch linux

# overview
 - shell: zsh
 - text editor: neovim
 - code search: ag (the silver searcher)
 - fuzzy finder: fzf
 - file manager: ranger
 - terminal emulator: alacritty
 - window manager: i3-gaps
 - status bar: i3blocks
 - notifications: dunst
 - process manager: bpytop

Previously, when using sway:
 - notifications: mako

See packages files for details.

Also, my .gitconfig includes aliases that make some common git commands (add, checkout, diff, reset) interactive, using fzf.

# setup
These directories are "packages" containing configuration files and standardized setup scripts
 - `core`: basic system utilities and core applications
 - `i3`: desktop environment, status bar
 - `desktop`: monitors, peripherals
 - `laptop`: touchpad, screen brightness, battery
 - `server`: icebox

Packages may contain any of the following files:
 - `pacman-packages.txt`: line-separated list of pacman packages, lines starting with `#` are ignored. install all packages with pacman by running `install-pacman.sh {path/to/pacman-packages.txt}`
 - `aur-packages.txt`: like `pacman-packages.txt`, but for packages in the AUR. install packages with yay by running `install-yay.sh {path/to/aur-packages.txt}`
 - `link.sh`: script that symlinks all configuration files to their appropriate locations in your `$HOME`. sometimes these add a broken link to a file called `*` because i'm bad at bash.

Configuration files are usually located in `etc`, `.config`, and `.dotfiles`.
Scripts to install to your system are usually located in `/usr`, `.local`

`nvim-python-setup.py` creates python virtual environments for python2 and python3 providers

# first time arch setup
`setup.sh` contains commands you should manually run one at a time to install the system after a fresh Arch install.  
then install the `core` and additional packages
