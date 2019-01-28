#/bin/bash
export IDF_PATH=$HOME/esp/esp-idf

mkdir $HOME/esp
git clone --recursive https://github.com/espressif/esp-idf.git $IDF_PATH
python2 -m pip install --user -r $IDF_PATH/requirements.txt

