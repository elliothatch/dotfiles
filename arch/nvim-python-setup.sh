#!/bin/bash
mkdir -p $HOME/.local/virtualenvs

python3 -m  virtualenv -p $(which python3) ~/.local/virtualenvs/neovim3
source $HOME/.local/virtualenvs/neovim3/bin/activate
pip install pynvim
deactivate

python3 -m  virtualenv -p $(which python2) ~/.local/virtualenvs/neovim2
source $HOME/.local/virtualenvs/neovim2/bin/activate
pip install pynvim
deactivate
