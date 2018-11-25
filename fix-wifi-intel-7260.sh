echo "options iwlwifi 11n_disable=1" | sudo tee /etc/modprobe.d/iwlwifi.conf
sudo modprobe -rfv iwlmvm
sudo modprobe -rfv iwlwifi
sudo modprobe -v iwlwifi
