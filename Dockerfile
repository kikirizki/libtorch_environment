ARG cuda_version=10.1
ARG cudnn_version=7
ARG ubuntu=18.04
ARG libtorch_version=1.4.0
FROM ubuntu:18.04
FROM nvidia/cuda:10.1-cudnn7-devel-ubuntu18.04 
MAINTAINER Kiki R
USER root
WORKDIR /root
RUN apt-get update && apt-get install -y wget zip git
RUN wget https://download.pytorch.org/libtorch/cu101/libtorch-cxx11-abi-shared-with-deps-1.4.0.zip 
RUN unzip libtorch*.zip && mv libtorch /usr/lib/libtorch_abi11_14
RUN rm *.zip
RUN wget https://download.pytorch.org/libtorch/cu101/libtorch-cxx11-abi-shared-with-deps-1.3.0.zip
RUN unzip libtorch*.zip && mv libtorch /usr/lib/libtorch_abi11_13
RUN rm *.zip
COPY opencv/ /usr/opencv
RUN apt-get install -y build-essential
RUN apt-get install -y cmake git libgtk2.0-dev pkg-config libavcodec-dev libavformat-dev libswscale-dev
RUN apt-get install -y python-dev python-numpy libtbb2 libtbb-dev libjpeg-dev libpng-dev libtiff-dev  libdc1394-22-dev
RUN cd /usr/opencv && mkdir build && cd build && cmake -D BUILD_SHARED_LIBS=OFF  -D WITH_GSTREAMER=ON  -D CMAKE_BUILD_TYPE=RELEASE .. && make -j6 && make install 
RUN apt-get install libssl-dev
