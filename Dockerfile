FROM ubuntu:18.04
ARG UBUNTU_CODE=bionic
ARG OS_USER=ubuntu
ARG OS_PASSWORD=$2a$10$Duh97ReJOfDmU2QIR3BdeuV5jfSHXgO4GR2DaSxeA9GlWbnh6CCKu
ARG TZ=Asia/Tokyo
ARG PG_VER=11
ARG RUBY_VER=2.6.3
ARG NODE_VER=12.1.0
RUN apt update && \
  apt upgrade -y
RUN apt install -y \
  curl \
  ca-certificates \
  gcc \
  git \
  gnupg1 \
  libreadline-dev \
  libssl-dev \
  make \
  sudo \
  vim \
  zlib1g-dev
RUN DEBIAN_FRONTEND=noninteractive apt install tzdata && \
  ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && \
  echo $TZ > /etc/timezone && \
  dpkg-reconfigure -f noninteractive tzdata
RUN curl https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add - && \
  sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt/ ${UBUNTU_CODE}-pgdg main" > /etc/apt/sources.list.d/pgdg.list' && \
  apt update && \
  apt install -y postgresql-client-${PG_VER} libpq-dev
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
  echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
  apt update && \
  apt install -y yarn
RUN useradd -m -p ${OS_PASSWORD} -s /bin/bash ${OS_USER} && \
  echo "${OS_USER} ALL=(ALL:ALL) NOPASSWD:ALL" > /etc/sudoers.d/${OS_USER}
USER ${OS_USER}
WORKDIR /home/${OS_USER}
RUN git clone https://github.com/anyenv/anyenv ~/.anyenv && \
  $HOME/.anyenv/bin/anyenv install --force-init && \
  echo 'export PATH="$HOME/.anyenv/bin:$PATH"' >> ~/.bashrc && \
  echo 'eval "$($HOME/.anyenv/bin/anyenv init -)"' >> ~/.bashrc
RUN /bin/bash -c 'PATH=$HOME/.anyenv/bin:$PATH && \
  anyenv install rbenv && \
  anyenv install nodenv' && \
  echo 'export PATH="$HOME/.anyenv/envs/rbenv/bin:$HOME/.anyenv/envs/nodenv/bin:$PATH"' >> ~/.bashrc && \
  echo 'eval "$(rbenv init -)"' >> ~/.bashrc && \
  echo 'eval "$(nodenv init -)"' >> ~/.bashrc
RUN /bin/bash -c 'PATH=$HOME/.anyenv/envs/rbenv/bin:$PATH && \
  eval "$($HOME/.anyenv/bin/anyenv init -)" && \
  rbenv install ${RUBY_VER} && \
  rbenv global ${RUBY_VER} && \
  rbenv rehash && \
  gem install bundle && \
  rbenv rehash'
RUN /bin/bash -c 'PATH=$HOME/.anyenv/envs/nodenv/bin:$PATH && \
  eval "$($HOME/.anyenv/bin/anyenv init -)" && \
  nodenv install ${NODE_VER} && \
  nodenv global ${NODE_VER} && \
  nodenv rehash'
