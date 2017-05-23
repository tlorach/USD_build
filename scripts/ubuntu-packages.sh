abort()
{
    echo -e >&2 '\e[1;31m
***************
*** ABORTED ***
***************
\e[0;37m'
    echo "something occurred in $0. Exiting..." >&2
    exit 1
}
#trap 'abort' 1
#set -e

echo -e "\e[1;32m-----------------------------------"
echo -e "\e[1;32m------- apt-get work..."
echo -e "\e[1;32m-----------------------------------"
echo -e "\e[0;37m"
sudo apt-get -y install python-dev || abort
sudo apt-get -y install qt-sdk || abort
sudo apt-get -y install libxxf86vm-dev || abort
sudo apt-get -y install libglew-dev || abort
sudo apt-get -y install libglfw3-dev || abort
sudo apt-get -y install libxrandr-dev  || abort
sudo apt-get -y install libxcursor-dev || abort
sudo apt-get -y install libxinerama-dev || abort
sudo apt-get -y install libxi-dev || abort
sudo apt-get -y install libjpeg-dev || abort

