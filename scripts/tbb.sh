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
------- TBB
----------------------
\e[0;37m"

if [ ! -d tbb2017_20170412oss ]; then
	echo -e "\e[1;32mdownloading from https://github.com/01org/tbb/releases/download/2017_U6/tbb2017_20170412oss_lin.tgz\e[0;37m"
	wget https://github.com/01org/tbb/releases/download/2017_U6/tbb2017_20170412oss_lin.tgz
	gunzip tbb2017_20170412oss_lin.tgz
	tar -xf tbb2017_20170412oss_lin.tar
	rm tbb2017_20170412oss_lin.tar
else
	echo -e "\e[1;32m
TBB already there
\e[0;37m"
fi



