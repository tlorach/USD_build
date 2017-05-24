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
echo -e "\e[1;32m------- USD"
echo -e "\e[1;32m-----------------------------------"
echo -e "\e[0;37m"

if [ ! -d USD ]; then
	echo -e "\e[1;32m-------> CLONING USD\e[0;37m"
	git clone https://github.com/PixarAnimationStudios/USD || abort
else
	echo -e "\e[1;32m-------> PULLING USD\e[0;37m"
	pushd USD
	git pull || abort
	popd
fi

if [ ! -d USD/cmake_build ]; then
  mkdir USD/cmake_build
fi
pushd USD/cmake_build
cmake -D BOOST_ROOT:path=`pwd`/../../boost_1_62_0 -D TBB_ROOT_DIR:path=`pwd`/../../tbb2017_20170412oss .. || abort
echo -e "\e[1;32m-------> install"
echo -e "\e[0;37m"
sudo make install || abort
popd


