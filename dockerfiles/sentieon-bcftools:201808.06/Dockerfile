FROM dnastack/sentieon-google-cloud:201808.06

# Last updated: May 2, 2019
MAINTAINER Heather Ward <heather@dnastack.com>

# Temporary fix; Jessie is now LTS
RUN sed -i '/jessie-updates/d' /etc/apt/sources.list  # Now archived

# Dependencies
RUN apt-get update && \
	apt-get -qq install \
	wget \
	make \
	gcc \
	bzip2 \
	zlib1g-dev \
	libbz2-dev \
	liblzma-dev \
	libcurl4-gnutls-dev \
	parallel \
	lsb-release \
	curl \
	gnupg2 \
	tabix

# bcftools 1.9
RUN wget https://github.com/samtools/bcftools/releases/download/1.9/bcftools-1.9.tar.bz2 && \
        tar -jxvf bcftools-1.9.tar.bz2 --directory /opt/ && \
        rm bcftools-1.9.tar.bz2
RUN cd /opt/bcftools-1.9 && \
        ./configure  && \
        make && \
        make install

# Install gcloud
RUN export CLOUD_SDK_REPO="cloud-sdk-$(lsb_release -c -s)" && \
	echo "deb http://packages.cloud.google.com/apt $CLOUD_SDK_REPO main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list && \
	curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add - && \
	apt-get update && \
	apt-get -qq install google-cloud-sdk

# Add scripts
COPY ./scripts/* /usr/local/bin/

ENV SHELL /bin/bash
