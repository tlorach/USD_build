abort()
{
    echo >&2 '
***************
*** ABORTED ***
***************
'
    echo "An error occurred. Exiting..." >&2
    exit 1
}
#trap 'abort' 0
#set -e

./scripts/ubuntu-packages.sh || abort
./scripts/boost.sh || abort
./scripts/tbb.sh || abort
./scripts/zlib.sh || abort
./scripts/double-conversion.sh || abort
./scripts/tiff.sh || abort
./scripts/png.sh || abort
./scripts/ilmbase.sh || abort
./scripts/openexr.sh || abort
./scripts/ptex.sh || abort
./scripts/oiio.sh || abort
./scripts/osd.sh || abort
./scripts/USD.sh || abort


