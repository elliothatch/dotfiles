#/bin/bash
export IDF_PATH=$HOME/esp32/esp-idf

mkdir $HOME/esp32
git clone --recursive https://github.com/espressif/esp-idf.git $IDF_PATH
python2 -m pip install --user -r $IDF_PATH/requirements.txt

gpasswd -a ellioth uucp

