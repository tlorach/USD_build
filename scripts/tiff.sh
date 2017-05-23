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
echo -e "\e[1;32m------- tiff-3.8.2"
echo -e "\e[1;32m-----------------------------------"
echo -e "\e[0;37m"

if [ ! -d tiff-3.8.2 ]; then
	echo -e "\e[1;32mdownloading from http://dl.maptools.org/dl/libtiff/tiff-3.8.2.tar.gz\e[0;37m"
	wget http://dl.maptools.org/dl/libtiff/tiff-3.8.2.tar.gz
	gunzip tiff-3.8.2.tar.gz
	tar -xf tiff-3.8.2.tar
	rm tiff-3.8.2.tar
fi

pushd tiff-3.8.2
./configure || abort
echo -e "\e[1;32m-------> install"
echo -e "\e[0;37m"
sudo make install || abort
popd


