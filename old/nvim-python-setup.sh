#!/bin/bash
python -m venv $HOME/.local/python-venv/neovim
#python -m venv --system-site-packages $HOME/.local/python-venv/neovim

source $HOME/.local/python-venv/neovim/bin/activate
python -m pip install pynvim
which python
deactivate
