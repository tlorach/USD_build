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
echo -e "\e[1;32m------- ilmbase-2.2.0"
echo -e "\e[1;32m-----------------------------------"
echo -e "\e[0;37m"

if [ ! -d ilmbase-2.2.0 ]; then
	echo -e "\e[1;32mdownloading from http://download.savannah.nongnu.org/releases/openexr/ilmbase-2.2.0.tar.gz\e[0;37m"
	wget http://download.savannah.nongnu.org/releases/openexr/ilmbase-2.2.0.tar.gz
	gunzip ilmbase-2.2.0.tar.gz
	tar -xf ilmbase-2.2.0.tar
	rm ilmbase-2.2.0.tar
fi

pushd ilmbase-2.2.0
./configure || abort
echo -e "\e[1;32m-------> install"
echo -e "\e[0;37m"
sudo make install || abort
popd


