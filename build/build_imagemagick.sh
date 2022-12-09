#!/usr/bin/env bash
set -e

cd /root

MAGICK_VERSION=$(curl -fsSLI -o /dev/null -w %{url_effective} https://github.com/ImageMagick/ImageMagick/releases/latest | rev | cut -d '/' -f 1 | rev)

curl https://github.com/ImageMagick/ImageMagick/archive/$MAGICK_VERSION.tar.gz -L -o tmp-imagemagick.tar.gz
tar xf tmp-imagemagick.tar.gz
cd ImageMagick*

PKG_CONFIG_PATH=/root/build/cache/lib/pkgconfig \
  ./configure \
    CPPFLAGS=-I/root/build/cache/include \
    LDFLAGS="-L/root/build/cache/lib -lstdc++" \
    --disable-dependency-tracking \
    --disable-shared \
    --enable-static \
    --prefix=/root/result \
    --enable-delegate-build \
    --disable-installed \
    --without-modules \
    --disable-docs \
    --without-magick-plus-plus \
    --without-perl \
    --without-x \
    --disable-openmp

make clean
make all
make install