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
echo -e "\e[1;32m------- zlib-1.2.11"
echo -e "\e[1;32m-----------------------------------"
echo -e "\e[0;37m"

if [ ! -d zlib-1.2.11 ]; then
	echo -e "\e[1;32mdownloading from http://www.zlib.net/zlib-1.2.11.tar.gz\e[0;37m"
	wget http://www.zlib.net/zlib-1.2.11.tar.gz
	gunzip zlib-1.2.11.tar.gz
	tar -xf zlib-1.2.11.tar
	rm zlib-1.2.11.tar
fi

pushd zlib-1.2.11
./configure || abort
echo -e "\e[1;32m-------> install"
echo -e "\e[0;37m"
sudo make install || abort
popd


