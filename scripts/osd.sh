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
echo -e "\e[1;32m------- OpenSubdiv"
echo -e "\e[1;32m-----------------------------------"
echo -e "\e[0;37m"

if [ ! -d OpenSubdiv ]; then
	echo -e "\e[1;32m-------> CLONING OpenSubdiv\e[0;37m"
	git clone https://github.com/PixarAnimationStudios/OpenSubdiv || abort
else
	echo -e "\e[1;32m-------> PULLING OpenSubdiv\e[0;37m"
	pushd OpenSubdiv
	git pull || abort
	popd
fi

if [ ! -d OpenSubdiv/cmake_build ]; then
  mkdir OpenSubdiv/cmake_build
fi
pushd OpenSubdiv/cmake_build
cmake -D TBB_LOCATION:path=`pwd`/../../tbb2017_20170412oss -D NO_CUDA=1 -D NO_CLEW=1 -D NO_DOC=1 -D NO_EXAMPLES=1 -D NO_GLTESTS=1 -D NO_OPENCL=1 -D NO_TUTORIALS=1 -D NO_DX=1 .. || abort
echo -e "\e[1;32m-------> install"
echo -e "\e[0;37m"
sudo make install || abort
popd


