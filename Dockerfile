ARG cuda_version=10.1
ARG cudnn_version=7
ARG ubuntu=16.04
ARG libtorch_version=1.3.0
FROM ubuntu:16.04
FROM nvidia/cuda:10.1-cudnn7-devel-ubuntu16.04 
MAINTAINER Kiki R
USER root
WORKDIR /root
RUN apt-get update && apt-get install -y wget zip git
RUN wget https://download.pytorch.org/libtorch/cu101/libtorch-cxx11-abi-shared-with-deps-1.3.0.zip 
RUN unzip libtorch*.zip && mv libtorch /usr/lib/libtorch_abi11_13
RUN git clone https://github.com/opencv/opencv && cd opencv && git checkout 3.4.5
RUN apt-get install -y build-essential
RUN apt-get install -y cmake git libgtk2.0-dev pkg-config libavcodec-dev libavformat-dev libswscale-dev
RUN apt-get install -y python-dev python-numpy libtbb2 libtbb-dev libjpeg-dev libpng-dev libtiff-dev libjasper-dev libdc1394-22-dev
RUN cd opencv && mkdir build && cd build && cmake -D BUILD_SHARED_LIBS=OFF  -D WITH_GSTREAMER=ON  -D CMAKE_BUILD_TYPE=RELEASE .. && make -j6 && make install 



