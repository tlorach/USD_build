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

echo -e "\e[1;32m
----------------------
------- BOOST
----------------------
\e[0;37m"

if [ ! -d boost_1_62_0 ]; then
	echo -e "\e[1;32mdownloading from https://sourceforge.net/projects/boost/files/boost/1.62.0/boost_1_62_0.tar.gz\e[0;37m"
	wget https://sourceforge.net/projects/boost/files/boost/1.62.0/boost_1_62_0.tar.gz
	gunzip boost_1_62_0.tar.gz
	tar -xf boost_1_62_0.tar
	rm boost_1_62_0.tar
fi

pushd boost_1_62_0
./bootstrap.sh || abort
echo -e "\e[1;32m-------> build"
echo -e "\e[0;37m"
./b2 || abort
popd


