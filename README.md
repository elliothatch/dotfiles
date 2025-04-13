# dotfiles
configuration and scripts for arch linux

## overview
 - shell: zsh
 - text editor: neovim
 - file manager: lf
 - process manager: bpytop

### graphics
 - window manager: sway
 - login manager: greetd + regreet
 - terminal emulator: alacritty
 - status bar: waybar
 - notifications: mako
 - launcher: rofi

### audio
 - framework: pipewire
 - patchbay: qpwgraph
 - music: mpd + cantata

See components for details.

.gitconfig includes aliases that make some common git commands (add, checkout, diff, reset) interactive, using fzf.

## setup
When installing Arch, manually follow the instructions in `pre-install.sh`. Then log into the user account and run the setup file for target machine (`./setup-labyrinth.sh`).

### components
Each of these directories is a "component" that contains configuration data and setup instructions for a part of the system.
 - `core`: basic system utilities and core applications
 - `wayland`: wayland compositor, login manager, and desktop environment
 - `icebox-client`: remote filesystem and syncthing setup for the icebox
 - `server`: configuration of the icebox itself

Components can have any of the standard files:
 - `setup.sh`: A setup script that can be run (in user mode) to install packages, copy/link configuration files, enable services, and perform any other setup
 - `pacman-packages.txt`: line-separated list of pacman packages, lines starting with `#` are ignored. install all packages with pacman by running `install-pacman.sh {path/to/pacman-packages.txt}`
 - `aur-packages.txt`: like `pacman-packages.txt`, but for packages in the AUR. install packages with yay by running `install-yay.sh {path/to/aur-packages.txt}`

System files are usually located in `etc` and `usr`, and are copied into the system on setup.
User files are usually located in `.config`, `.local`, and `dotfiles`, and are symlinked into the user's directories on setup.
