#!/bin/bash
mkdir nvim/python

python3 -m virtualenv -p `which python3` nvim/python/python3
source ./nvim/python/python3/bin/activate
pip install neovim
deactivate

python3 -m virtualenv -p `which python2` nvim/python/python2
source ./nvim/python/python2/bin/activate
pip install neovim
deactivate
