FROM jetbrains/teamcity-minimal-agent:latest

# no docs for gems
RUN mkdir -p /etc/ \
	&& { \
		echo 'install: --no-document'; \
		echo 'update: --no-document'; \
	} >> /etc/gemrc  

# remove tty warning when executing login shells    
RUN sed -i 's/^mesg n || true$/tty -s \&\& mesg n/g' /root/.profile

# install git, rvm, nodejs, yarn and Qt
ARG BUILD_PACKAGES="software-properties-common"
ARG RUN_PACKAGES="git rvm nodejs yarn qt5-default libqt5webkit5-dev gstreamer1.0-plugins-base gstreamer1.0-tools gstreamer1.0-x libcurl4-openssl-dev"
RUN apt-get update \
	&& apt-get install -y --no-install-recommends $BUILD_PACKAGES \
    && curl -sL https://deb.nodesource.com/setup_8.x | bash - \
    && curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
    && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \   
    && apt-add-repository -y ppa:rael-gc/rvm \
    && apt-get update \
    && apt-get install -y --no-install-recommends $RUN_PACKAGES \
    && rm -rf /var/lib/apt/lists/* 

# install ruby, update rubygems & install bundler
ARG RUBY_VERSION=2.4.3
ARG RUBYGEMS_VERSION=2.7.5
ARG BUNDLER_VERSION=1.16.1 
ARG SOURCE_RVM="source /usr/share/rvm/scripts/rvm"  
ARG RUBY_INSTALL="rvm install ${RUBY_VERSION}" 
ARG GEM_UPDATE="gem update --system ${RUBYGEMS_VERSION}"
ARG BUNDLER_INSTALL="rvm @global do gem install bundler --version ${BUNDLER_VERSION}"
ARG BUNDLER_CONFIG="bundle config --global silence_root_warning 1"
RUN /bin/bash -c "${SOURCE_RVM} && ${RUBY_INSTALL} && ${GEM_UPDATE} && ${BUNDLER_INSTALL} && ${BUNDLER_CONFIG}"

# provide defaults for the executing container
CMD /bin/bash -c "source /usr/share/rvm/scripts/rvm && source run-services.sh"