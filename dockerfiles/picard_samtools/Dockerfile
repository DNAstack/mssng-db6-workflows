FROM ubuntu:xenial

# Last updated: March 7, 2019
MAINTAINER Heather Ward <heather@dnastack.com>

RUN apt-get -qq update && \
	apt-get -qq install \
	wget \
	make \
	gcc \
	build-essential \
	libz-dev \
	libncurses5-dev \
	libbz2-dev \
	liblzma-dev \
	default-jre

# Install PICARD 2.18.9
RUN wget -P /usr/java/ https://github.com/broadinstitute/picard/releases/download/2.18.9/picard.jar
ENV PICARD /usr/java/picard.jar

# Install samtools 1.8
RUN wget https://github.com/samtools/samtools/releases/download/1.8/samtools-1.8.tar.bz2 && \
        tar -jxvf samtools-1.8.tar.bz2 --directory /opt/ && \
        rm samtools-1.8.tar.bz2
RUN cd /opt/samtools-1.8 && \
        ./configure --prefix=/usr/local/ && \
        make && \
        make install
