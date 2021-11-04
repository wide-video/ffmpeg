#!/bin/bash

set -euo pipefail
source $(dirname $0)/var.sh

# clean
rm $BUILD_DIR/lib/librubberband.a -f

LIB_PATH=third_party/librubberband
CONF_FLAGS=(
  --prefix=$BUILD_DIR                                 # install library in a build directory for FFmpeg to include
  --host=i686-gnu                                     # use i686 linux
  --enable-shared=no                                  # not to build shared library
  --disable-asm                                       # not to use asm
  --disable-rtcd                                      # not to detect cpu capabilities
  --disable-doc                                       # not to build docs
  --disable-extra-programs                            # not to build demo and tests
  --disable-stack-protector
)
echo "CONF_FLAGS=${CONF_FLAGS[@]}"

LIB_PATH1=third_party/libsamplerate
#(cd $LIB_PATH1 && \
#  emconfigure ./autogen.sh && \
#  CFLAGS=$CFLAGS emconfigure ./configure "${CONF_FLAGS[@]}")
#emmake make -C $LIB_PATH1 clean
#emmake make -C $LIB_PATH1 install

LIB_PATH2=third_party/libsndfile
#(cd $LIB_PATH2 && \
#  emconfigure ./autogen.sh && \
#  CFLAGS=$CFLAGS emconfigure ./configure "${CONF_FLAGS[@]}")
#emmake make -C $LIB_PATH2 clean
#emmake make -C $LIB_PATH2 install

export CPATH="${BUILD_DIR}/include"
#emmake make -C $LIB_PATH -f otherbuilds/Makefile.linux clean
#emmake make -C $LIB_PATH -f otherbuilds/Makefile.linux

cp $LIB_PATH/lib/librubberband.a $BUILD_DIR/lib
cp $LIB_PATH/rubberband.pc.in $EM_PKG_CONFIG_PATH/rubberband.pc
sed -i -e 's,%PREFIX%,'"$BUILD_DIR"',g' $EM_PKG_CONFIG_PATH/rubberband.pc
echo "Requires: samplerate" >> $EM_PKG_CONFIG_PATH/rubberband.pc


cp $LIB_PATH/rubberband/RubberBandStretcher.h $BUILD_DIR/include
cp $LIB_PATH/rubberband/rubberband-c.h $BUILD_DIR/include