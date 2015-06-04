#!/bin/sh

PUPPET_DIR=/etc/puppet/

apt-get -q -y install git
apt-get -y install librarian-puppet

mkdir -p $PUPPET_DIR
cp /vagrant/puppet/Puppetfile $PUPPET_DIR

cd $PUPPET_DIR
librarian-puppet install --clean
