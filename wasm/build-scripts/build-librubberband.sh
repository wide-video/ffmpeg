#!/bin/bash

set -euo pipefail
source $(dirname $0)/var.sh

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

#LIB_PATH1=third_party/libsamplerate
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

LIB_PATH3=third_party/fftw3
#(mkdir $LIB_PATH3 && cd $LIB_PATH3 && \
#  wget http://fftw.org/fftw-3.3.3.tar.gz && \
#  tar -xvf fftw-3.3.3.tar.gz && \
#  cd fftw-3.3.3 && \
#  CFLAGS=$CFLAGS emconfigure ./configure "${CONF_FLAGS[@]}")
#emmake make -C $LIB_PATH3/fftw-3.3.3
#emmake make -C $LIB_PATH3/fftw-3.3.3 install

LIB_PATH=third_party/librubberband
#export CPATH="${BUILD_DIR}/include"
    #2.0.0
    #emmake make -C $LIB_PATH -f otherbuilds/Makefile.linux clean distclean default
(cd $LIB_PATH && \
  CFLAGS=$CFLAGS emconfigure ./configure static "${CONF_FLAGS[@]}")


#cp $LIB_PATH/lib/librubberband.a $BUILD_DIR/lib
#cp $LIB_PATH/rubberband.pc.in $EM_PKG_CONFIG_PATH/rubberband.pc
#sed -i -e 's,%PREFIX%,'"$BUILD_DIR"',g' $EM_PKG_CONFIG_PATH/rubberband.pc
#echo "Requires: samplerate" >> $EM_PKG_CONFIG_PATH/rubberband.pc

#mkdir -p $BUILD_DIR/include/rubberband
#cp $LIB_PATH/rubberband/RubberBandStretcher.h $BUILD_DIR/include/rubberband/RubberBandStretcher.h
#cp $LIB_PATH/rubberband/rubberband-c.h $BUILD_DIR/include/rubberband/rubberband-c.h

#cp $BUILD_DIR/lib/libsamplerate.la $BUILD_DIR/lib/librubberband.la
#sed -i 's/libsamplerate/librubberband/g' $BUILD_DIR/lib/librubberband.la