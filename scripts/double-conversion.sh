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
echo -e "\e[1;32m------- double-conversion"
echo -e "\e[1;32m-----------------------------------"
echo -e "\e[0;37m"
if [ ! -d double-conversion ]; then
	echo -e "\e[1;32m-------> CLONING double conversion\e[0;37m"
	git clone https://github.com/google/double-conversion || abort
else
	echo -e "\e[1;32m-------> PULLING double conversion\e[0;37m"
	pushd double-conversion
	git pull || abort
	popd
fi

if [ ! -d double-conversion/cmake_build ]; then
  mkdir double-conversion/cmake_build
fi
pushd double-conversion/cmake_build
cmake .. || abort
echo -e "\e[1;32m-------> install"
echo -e "\e[0;37m"
sudo make install || abort
popd


