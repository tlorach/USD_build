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
echo -e "\e[1;32m------- oiio"
echo -e "\e[1;32m-----------------------------------"
echo -e "\e[0;37m"

if [ ! -d oiio ]; then
	echo -e "\e[1;32m-------> CLONING oiio\e[0;37m"
	git clone https://github.com/OpenImageIO/oiio || abort
else
	echo -e "\e[1;32m-------> PULLING oiio\e[0;37m"
	pushd oiio
	git pull || abort
	popd
fi

if [ ! -d oiio/cmake_build ]; then
  mkdir oiio/cmake_build
fi
pushd oiio/cmake_build
cmake -D BOOST_ROOT:path=`pwd`/../../boost_1_62_0 -D STOP_ON_WARNING=0 -D BUILD_TESTING=0 -D OIIO_BUILD_TESTS=0 .. || abort
echo -e "\e[1;32m-------> install"
echo -e "\e[0;37m"
sudo make install || abort
popd


