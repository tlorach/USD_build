# Building Pixar's USD
This git repository is meant to help you building USD:
https://github.com/PixarAnimationStudios/USD
The scripts should be able to do everything for you:
- download packages or clone them
- gunzip and tar -xf if needed
- ./config if needed
- cmake setup if needed
- make install

The ultimate result should be to have a fully compiled version of *USD*

For more details on USD, please refer to this page:
http://graphics.pixar.com/usd/docs/Introduction-to-USD.html

Notes on the scripts:
- Tested on Ubuntu 16.04. But 14.xx should work, too (I started with v14)
- Never tested with other Linux distributions
- strongly relies on *cmake* and *apt-get*
- I am pulling specific versions of packages (when not using git). I do *not* test for the latest packages. So if the server removes or updates the versions, the script could fail. At least, the script won't look for the latest build
- **TODO**: it is possible that I should improve the ./configure call to prevent useless build when already built...

## Notes on installing USD "by hand"
Here are the notes I took when trying to gather everything consistently for USD to compile. Although these notes aren't relevant for using the scripts, I wanted to keep there and share them here, so that one could better figure-out what is at stake.
When I was figuring-out which Ubuntu packages were needed, I often used this linke to check dependencies and required packages:
Quite interesting to have a look at debian packages to know what to take:
https://www.debian.org/distrib/packages#search_contents

### get ready for git
You need to make sure you have a proper RSA key for SSH, so git can clone/pull properly
<todo add details>
### Python
`sudo apt-get install python-dev`
### Boost
It is unfortunate but you need boost :-/
Get boost at http://www.boost.org/users/history/version_1_62_0.html
Then:
- `./bootstrap.sh`
- then `./b2` to build
- You will need to set BOOST_ROOT as a path variable in cmake ( *thefulpath/boost_1_62_0* )

### Threading Building Blocks
At https://www.threadingbuildingblocks.org/
Just keep it where you downloaded it: it already contains the binaries... and not need to bother with installing it (it turned out to be a problem for me). Then later you just need to set `TBB_LOCATION` to its path, in cmake

### double conversion
At https://github.com/google/double-conversion
- run `cmake`
- `make` and/or `sudo make install`

### Open Image IO
At https://github.com/OpenImageIO/oiio
A first easy solution would be to install the existing one in the packages: 
- `sudo apt-get install libopenimageio-dev` 
- `sudo apt-get install openimageio-tools`

But I found better to build it...

To build it, you'll need the following:
- install *libtiff* from http://dl.maptools.org/dl/libtiff/
-- download it
-- invoke `./configure`
-- `make` and/or `sudo make install`
then you need zlib: http://www.zlib.net/ ( ./configure; make; sudo make install)...

### PNG library
At http://www.libpng.org/pub/png/libpng.html 
- OpenEXR is needed: *see below*
- set in cmake the path variable `BOOST_ROOT` to the boost's path
- needs *jpeg* http://libjpeg.sourceforge.net/
-- If building it: it turned out that `sudo make install` did lead to some bad install procedure and prevented *oiio* to find the libraries/includes
-- solution that worked for me: simple `sudo apt-get install libjpeg-dev`

Then you can build oiio ! But with these changes in cmake options:
- uncheck *"Stop on Warnings"*
- remove the *build of tests*... no use
- You must *Keep* `OIIO_BUILD_TOOLS`

### OpenEXR
At http://www.openexr.com/
Either build it and install it:
- install ilmbase-2.2.0.tar.gz first
- or use Ubuntu: `sudo apt-get install libilmbase-dev`; `sudo apt-get install openexr`; `sudo apt-get install libopenexr-dev`

I found fine to just build it...

### PTex
At https://github.com/wdas/ptex
cmake needs *zlib*
- get zlib at http://www.zlib.net/
-- on zlib: run `./configure`
-- `make` and/or `sudo make install`
- On PTex: `make`; `sudo make install`

### OpenSubdiv
At https://github.com/PixarAnimationStudios/OpenSubdiv 
- In cmake Set `TBB_LOCATION` to where to find the folder
- For OpenGL use uncheck `NO_OPENGL`
_Note_: I remember I got a linkage error with libGL.so... Nevertheless, you must make sure some gl and X11 packages are there:
-- `sudo apt-get install libxxf86vm-dev`
-- `sudo apt-get install libglew-dev`
-- `sudo apt-get install libglfw-dev`
-- `sudo apt-get install libxrandr-dev`
-- `sudo apt-get install libxcursor-dev`
-- `sudo apt-get install libxinerama-dev`
-- `sudo apt-get install libxi-dev`

Then you might want to *cancel anything that prevents to setup cmake*. At this point, it is up to you. For USD, I didn't bother using OpenCL or CUDA:
- `NO_CUDA` checked
- at least, I could keep OpenGL
- keep `NO_PTEX` unchecked: we installed this library
- `make` and/or `sudo make install`

later for USD:
- set `OPENSUBDIV_ROOT_DIR` to /usr/local : where OpenSubdiv got installed
- if you used PTex, you still need zlib: http://www.zlib.net/ ( ./configure; make; sudo make install)...

### Qt
I certainly didn't bother installing anything related to Qt outside of Ubuntu package system...
- `sudo apt-get install qt-sdk`

### Python
USD relies heavily on Python !
could you need `Pyside`... howewver it may not be so necessary: I could configure everything without it in a second test:
-- sudo apt-get install libpyside-dev
-- sudo apt-get install pyside-tools

Python needs an OpenGL module: 
- `apt-get install python-opengl`

## Possible issues with cmake for USD
These are issues I encoutered but, later, when trying again with a brand new system (Ubuntu 16.04), I did not get these errors anymore. However given we never know what can happen on another machine, I did prefer to keep these details here for whoever might encounter the same:

### OIIO version issues
I think this issue came from the fact I tried the package of oiio instead of the latest source code. Leading to some missing entry points
- The latest USD souce is using "`ImageBufAlgo::cut(...)`". But it seems like the oiio from Ubuntu is not up to date for it... yet. 
I Needed to comment this function in `/USD/pxr/imaging/lib/glf/oiioImage.cpp line 440`. If you built the new oiio, then you shouldn't have any problem
- `OpenImageIO/oiioversion.h` didn't exist... probably again due to some version discrepancy. I replaced this name  with `version.h` and it worked
- Always make sure you set in cmake BOOST_ROOT to the path for boost_1_62_0

### OpenEXR
if using an older version or pulling things from apt-get, it is possible that cmake script, in `FindOpenEXR.cmake` fails: it turns out that the *regexp* to track the version fails. `OPENEXR_VERSION_STRING` does NOT exist in OpenEXR. 
- You can edit `FindOpenEXR.cmake` at line 87 : `REGEX "#define PACKAGE_VERSION.*$")`

If you installed from apt-get, it is possible that `OPENEXR_${OPENEXR_LIB}_LIBRARY` / `OPENEXR_LIBRARY_DIR` needs to look into `lib/x86_64-linux-gnu/`... 
*Note*: If you compile it, install would put it in `/usr/local/lib` and shouldn't raise any issue

### OpenSubdiv
OpenSubdiv must be installed in `/usr/local` in any case, it seems...
- at some point I needed to add in l.29 of `FindOpenSubdiv.cmake`: 
`ELSE() SET(OPENSUBDIV_ROOT_DIR "/usr/local")`
- in the same `FindOpenSubdiv.cmake`, line 32: not sure what needs to be set for osdGPU (see _opensubdiv_FIND_COMPONENTS) ?? I Commented-out this part when I had this issue...
- 
