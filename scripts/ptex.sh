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
echo -e "\e[1;32m------- ptex"
echo -e "\e[1;32m-----------------------------------"
echo -e "\e[0;37m"

if [ ! -d ptex ]; then
	echo -e "\e[1;32m-------> CLONING ptex\e[0;37m"
	git clone https://github.com/wdas/ptex || abort
else
	echo -e "\e[1;32m-------> PULLING ptex\e[0;37m"
	pushd ptex
	git pull || abort
	popd
fi


if [ ! -d ptex/cmake_build ]; then
  mkdir ptex/cmake_build
fi
pushd ptex/cmake_build
cmake .. || abort
echo -e "\e[1;32m-------> install"
echo -e "\e[0;37m"
sudo make install || abort
popd


