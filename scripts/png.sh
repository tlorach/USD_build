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
echo -e "\e[1;32m------- libpng-1.6.29"
echo -e "\e[1;32m-----------------------------------"
echo -e "\e[0;37m"

if [ ! -d libpng-1.6.29 ]; then
	echo -e "\e[1;32mdownloading from ftp://ftp-osl.osuosl.org/pub/libpng/src/libpng16/libpng-1.6.29.tar.gz\e[0;37m"
	wget ftp://ftp-osl.osuosl.org/pub/libpng/src/libpng16/libpng-1.6.29.tar.gz
	gunzip libpng-1.6.29.tar.gz
	tar -xf libpng-1.6.29.tar
	rm libpng-1.6.29.tar
fi

pushd libpng-1.6.29
./configure || abort
echo -e "\e[1;32m-------> install"
echo -e "\e[0;37m"
sudo make install || abort
popd


