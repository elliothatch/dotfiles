export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

export TERMCMD=termite

# export VISUAL=nvim-gui
export VISUAL=nvim
export EDITOR=nvim

export PAGER=less
export LESS=RM

export PATH=$PATH:~/.local/bin

export GOPATH=~/go

export FZF_DEFAULT_COMMAND='ag -l --hidden --path-to-ignore $HOME/.config/ag/.ignore'

export I3BLOCKS_SCRIPT_DIR=$HOME/.config/i3blocks/scripts
export IDF_PATH=$HOME/esp/esp-idf

export PATH=~/.fnm:$PATH
eval "`fnm env --multi`"

export PATH=$PATH:$HOME/.yarn/bin
