#!/bin/bash

# remove comment if you want to enable debugging
#set -x

source /tmp/.env

## add new user
# useradd -m -s /bin/bash -U ${USERNAME} -u ${USER_UID}
# cp -pr /home/vagrant/.ssh ${HOME_DIR}/
# chown -R ${USERNAME}:${USERNAME} ${HOME_DIR}
# echo "%${USERNAME} ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/${USERNAME}


# #### Install packages ######
apt-get update -y
#apt-get install -y build-essential linux-headers-generic

#set default python3
  apt-get install -y ${PYTHON_VERSION}-pip \
      libssl-dev zlib1g-dev libncurses5-dev libncursesw5-dev libreadline-dev libsqlite3-dev libpq-dev \
      libgdbm-dev libdb5.3-dev libbz2-dev libexpat1-dev liblzma-dev libffi-dev uuid-dev ${PYTHON_VERSION}-dev

  rm -f /usr/bin/python
  pip3 install --upgrade setuptools==${PIP_SETUPTOOLS}
  ln -s /usr/bin/${PYTHON_VERSION} /usr/bin/python

#add git repo
add-apt-repository -y ppa:git-core/ppa

#install git
  apt-get install -y git
  curl -fsSL https://packagecloud.io/install/repositories/github/git-lfs/script.deb.sh | sudo bash -\
      && apt-get install -y git-lfs

#nodejs
  curl -sL https://deb.nodesource.com/setup_${NODE_VERSION} | bash - \
    && apt-get install -y nodejs

# install redis
  apt install -y redis-server redis-tools

# mongo installation
  wget -qO- https://www.mongodb.org/static/pgp/server-${MONGO_BASE_DIR}.asc | apt-key add - &&\
      echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/${MONGO_BASE_DIR} multiverse" | tee /etc/apt/sources.list.d/mongodb-org-${MONGO_BASE_DIR}.list &&\
      apt-get update -y &&\
      apt-get install -y mongodb-org-server=${MONGO_VERSION} \
      mongodb-org-shell=${MONGO_VERSION} \
      mongodb-org-mongos=${MONGO_VERSION} \
      mongodb-org-tools=${MONGO_VERSION}

  #make mongo data directory
  mkdir -p /data/db
  chown -R mongo:mongo /data/db

  #start mongo service
  systemctl enable mongod.service
  service mongod start

#postgres installation
  wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add - &&\
    echo "deb http://apt.postgresql.org/pub/repos/apt/ $(lsb_release -cs)-pgdg main" | tee /etc/apt/sources.list.d/pgdg.list &&\
    apt-get update -y &&\
    apt-get install -y postgresql-${POSTGRES_VERSION}

#erlang & rabbitmq installation
  curl -fsSL https://github.com/rabbitmq/signing-keys/releases/download/2.0/rabbitmq-release-signing-key.asc | sudo apt-key add - &&\
    echo "deb http://dl.bintray.com/rabbitmq-erlang/debian $(lsb_release -cs) erlang" | tee /etc/apt/sources.list.d/bintray.erlang.list &&\
    echo "deb https://dl.bintray.com/rabbitmq/debian $(lsb_release -cs) main" | tee /etc/apt/sources.list.d/bintray.rabbitmq.list &&\
    apt-get update -y &&\
    apt-get install -y erlang-base \
      erlang-asn1 erlang-crypto erlang-eldap erlang-ftp erlang-inets \
      erlang-mnesia erlang-os-mon erlang-parsetools erlang-public-key \
      erlang-runtime-tools erlang-snmp erlang-ssl \
      erlang-syntax-tools erlang-tftp erlang-tools erlang-xmerl

  wget https://github.com/rabbitmq/rabbitmq-server/releases/download/v${RABBITMQ_VERSION}/rabbitmq-server_${RABBITMQ_VERSION}-1_all.deb &&\
    apt-get -y install socat &&\
    dpkg -i rabbitmq-server_${RABBITMQ_VERSION}-1_all.deb &&\
    rm rabbitmq-server_${RABBITMQ_VERSION}-1_all.deb