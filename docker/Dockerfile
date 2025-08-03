FROM debian:buster-20200514-slim

LABEL \
	maintainer="Michel Stempin <michel.stempin@funkey-project.com>" \
	vendor="FunKey Project" \
	description="Container with everything needed to build FunKey-OS"

# Setup environment
ENV DEBIAN_FRONTEND noninteractive

RUN \
	# Install dependencies
	# See https://buildroot.org/downloads/manual/manual.html#requirement
	apt-get update && \
	apt-get install -y -q --no-install-recommends \
	# MANDATORY build tools
	#which \
	#sed \
	make \
	binutils \
	build-essential \
	gcc \
	g++ \
	#bash \
	patch \
	#gzip \
	bzip2 \
	perl \
	#tar \
	cpio \
	unzip \
	rsync \
	file \
	bc \
	# MANDATORY source fetching tools
	wget \
	# OPTIONAL recommended dependencies
	python \
	python-dev \
	xxd \
	# OPTIONAL configuration interface dependencies
	libncurses5-dev \
	#libqt5-dev \
	#libglib2.0-dev libgtk2.0-dev libglade2-dev \
	# OPTIONAL source fetching tools
	#bazaar \
	# bzr \
	cvs \
	git \
	mercurial \
	rsync \
	liblscp-dev \
	subversion \
	# OPTIONAL java related packages
	#javacc \
	#jarwrapper \
	# OPTIONAL documentation generation tools
	#asciidoc \
	#w3m \
	python3 \
	python3-dev \
	python3-distutils \
	python3-setuptools \
	#dblatex \
	# OPTIONAL graph generation tools
	#graphviz \
	#python-matplotlib \
	#
	# ADDITIONAL dependency to get root certificates
	ca-certificates \
	# ADDITIONAL dependency to get client ssh
	openssh-client \
	# ADDITIONAL dependency to get unbuffer
	expect \
	# ADDITIONAL dependency to get locale-gen
	locales \
	# ADDITIONAL nice to have dependencies
	sudo \
	procps \
	&& \
	apt-get -y autoremove && \
	apt-get -y clean && \
	rm -rf /var/lib/apt/lists/* && \
	#
	# Set locale
	sed -i 's/# \(en_US.UTF-8\)/\1/' /etc/locale.gen && \
	locale-gen --purge --lang en_US.UTF-8  && \
	#
	# Add user
	useradd -ms /bin/bash funkey && \
	usermod -a -G sudo funkey && \
	echo "funkey:funkey" | chpasswd && \
	#
	# Clone the FunKey-OS repository
	git clone https://github.com/DrUm78/FunKey-OS.git /home/funkey/FunKey-OS && \
	#
	# Set file ownership
	chown -R funkey:funkey /home/funkey

# Set user
USER funkey

# Set working directory
WORKDIR /home/funkey/FunKey-OS

# Set environment
ENV \
	HOME=/home/funkey \
	LC_ALL=en_US.UTF-8

# VOLUME ["/home/funkey/.buildroot-ccache", \
# 	"/home/funkey/FunKey-OS/buildroot", \
# 	"/home/funkey/FunKey-OS/dowload", \
# 	"/home/funkey/FunKey-OS/images", \
# 	"/home/funkey/FunKey-OS/Recovery/output/build", \
# 	"/home/funkey/FunKey-OS/Recovery/output/host", \
# 	"/home/funkey/FunKey-OS/Recovery/output/target", \
# 	"/home/funkey/FunKey-OS/FunKey/output/host", \
# 	"/home/funkey/FunKey-OS/FunKey/output/build", \
# 	"/home/funkey/FunKey-OS/FunKey/output/target"]

CMD ["/usr/bin/make", "sdk", "all", "-C", "/home/funkey/FunKey-OS"]
