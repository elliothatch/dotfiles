#!/bin/bash
mkdir -p ~/.local/virtualenvs

python3 -m  virtualenv -p `which python3` ~/.local/virtualenvs/neovim3
source ~/.local/virtualenvs/neovim3/bin/activate
pip install neovim
deactivate

python3 -m  virtualenv -p `which python2` ~/.local/virtualenvs/neovim2
source ~/.local/virtualenvs/neovim2/bin/activate
pip install neovim
deactivate
