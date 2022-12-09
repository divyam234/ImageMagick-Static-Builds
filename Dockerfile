# syntax=docker/dockerfile:1

FROM ubuntu:20.04

RUN apt-get update \
    && apt-get -y --no-install-recommends install build-essential curl ca-certificates libva-dev \
        python3 python-is-python3 ninja-build meson git  \ 
        cpio make cmake automake autoconf clang  dos2unix zlib1g-dev zip unzip tar perl \
         libxml2 bzip2 pkgconfig libtool \
    && apt-get clean; rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/share/doc/* \
    && update-ca-certificates


ADD build /root/build

# Remove the ones you don't need...
RUN /root/build/build_libjpeg.sh
RUN /root/build/build_libpng.sh
RUN /root/build/build_libwebp.sh
RUN /root/build/build_libde265.sh
RUN /root/build/build_libheif.sh
RUN /root/build/build_libopenjp2.sh
RUN /root/build/build_libtiff.sh
RUN /root/build/build_libbz2.sh
RUN /root/build/build_lcms.sh

# And finally...
RUN /root/build/build_imagemagick.sh