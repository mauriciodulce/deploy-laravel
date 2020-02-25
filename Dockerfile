FROM ubuntu:18.04


# install git and other deps
RUN ln -sf /usr/share/zoneinfo/UTC /etc/localtime
RUN apt-get -qq update && apt-get -qq install git wget libssl-dev build-essential software-properties-common rsync openssh-client
RUN apt-get update && apt-get install -y --no-install-recommends apt-utils


# add the newest git-ftp PPA and update the installation
RUN add-apt-repository ppa:git-ftp/ppa && apt-get update && apt-get -qq install git-ftp

# get and build libssh2 and curl
RUN wget https://www.libssh2.org/download/libssh2-1.9.0.tar.gz
RUN tar -xvzf libssh2-1.9.0.tar.gz
RUN cd libssh2-1.9.0 && ./configure && make && make install
RUN wget https://curl.haxx.se/download/curl-7.65.3.tar.bz2
RUN tar -xvjf curl-7.65.3.tar.bz2
RUN cd curl-7.65.3 && ./configure --with-libssh2=/usr/local && make && make install
RUN ldconfig

# get and install git lfs
RUN curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.deb.sh | bash
RUN apt-get -qq install git-lfs
RUN git lfs install

# Install Nodejs
RUN curl --silent --location https://deb.nodesource.com/setup_12.x | bash -
RUN apt-get update
RUN apt-get install -y --force-yes nodejs
RUN npm install -g pm2
RUN npm install -g gulp
RUN npm install -g yarn



# Install PHP
RUN apt-get install -y --force-yes php7.2-cli php7.2-dev \
		php7.2-pgsql php7.2-sqlite3 php7.2-gd \
		php7.2-curl php7.2-memcached \
		php7.2-imap php7.2-mysql php7.2-mbstring \
		php7.2-xml php7.2-zip php7.2-bcmath php7.2-soap \
		php7.2-intl php7.2-readline

