# syntax=docker/dockerfile:1

ARG VER=20.04

FROM ubuntu:${VER}

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update \
    && apt-get -y --no-install-recommends install build-essential curl ca-certificates libva-dev \
        python3 ninja-build meson git  \ 
        cpio make cmake automake autoconf clang  dos2unix zlib1g-dev zip unzip tar perl \
         libxml2 bzip2 pkg-config libtool \
    && apt-get clean; rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/share/doc/* \
    && update-ca-certificates
    
RUN add-apt-repository ppa:ubuntu-toolchain-r/test -y >/dev/null 2>&1

RUN apt update && apt install gcc-11 g++-11 -y 

RUN update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-11 60 --slave /usr/bin/g++ g++ /usr/bin/g++-11

RUN update-alternatives --install /usr/bin/python python /usr/bin/python3 10

ADD build /root/build


# Remove the ones you don't need...
RUN /root/build/build_libjpeg.sh
RUN /root/build/build_libpng.sh
RUN /root/build/build_libwebp.sh
RUN /root/build/build_libde265.sh
# RUN /root/build/build_libheif.sh
RUN /root/build/build_libopenjp2.sh
RUN /root/build/build_libtiff.sh
RUN /root/build/build_libbz2.sh
RUN /root/build/build_lcms.sh

# And finally...
RUN /root/build/build_imagemagick.sh
