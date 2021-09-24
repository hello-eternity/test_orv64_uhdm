#!/bin/bash
#
# Script to build RISC-V ISA simulator, proxy kernel, and GNU toolchain.
# Tools will be installed to $RISCV.

## # export PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
export PATH=/usr/local/bin/:/usr/sbin:/usr/bin:/sbin:/bin:$PATH

#export RISCV=/work/tools/ours-gnu-toolchain/riscv/
export MAKEFLAGS="$MAKEFLAGS -j16"
export PKG_CONFIG_PATH=/usr/local/lib/pkgconfig:/usr/lib/pkgconfig
export PATH=$RISCV/bin:$PATH
export LD_LIBRARY_PATH=$RISCV/lib:/usr/local/lib64:/usr/local/lib
export CC=gcc
export CXX=g++


echo "Starting RISC-V Toolchain build process"

which gcc
gcc --version
if [ "$1" = "" ]; then
  echo "Please pass project name as argument. Example: ./build-fesvr.sh es1y"
  exit
else
  PROJ=$1
fi

export PROJECT_NAME=$PROJ

if [[ "$1" == "es1y" ]]; then
PROJ_NUM=0
fi


. build.common

CFLAGS="-g -I${PROJ_ROOT}/hardware/soc/subproj/${PROJ}/rtl_gen/ -DPROJ_NUM=${PROJ_NUM}" CPPFLAGS="-g -I${PROJ_ROOT}/hardware/soc/subproj/${PROJ}/rtl_gen/ -DPROJ_NUM=${PROJ_NUM}" build_project riscv-fesvr --prefix=$RISCV --proj=$PROJ

echo -e "\\nRISC-V Toolchain installation completed!"
