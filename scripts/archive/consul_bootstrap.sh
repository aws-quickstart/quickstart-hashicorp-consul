#!/bin/bash
#This script configures consul. Slight modifications of https://github.com/hashicorp/best-practices
set -e

echo Install dependencies...
# Update the box
apt-get -y update
apt-get -y upgrade

# Install dependencies
apt-get -y install curl unzip jq

cd /tmp

CONSULVERSION=0.6.3
CONFIGDIR=/opt/consul/config
CONSULDOWNLOAD=https://releases.hashicorp.com/consul/${CONSULVERSION}/consul_${CONSULVERSION}_linux_amd64.zip
CONSULWEBUI=https://releases.hashicorp.com/consul/${CONSULVERSION}/consul_${CONSULVERSION}_web_ui.zip
CONSULCONFIGDIR=/etc/consul.d
CONSULDIR=/opt/consul
UPSTARTCONF=https://s3-us-west-2.amazonaws.com/43d3.brandonchav.is/consul-upstart.conf
DATADIR=/opt/consul/data

echo Fetching Consul...
curl -L $CONSULDOWNLOAD > consul.zip

echo Installing Consul...
unzip consul.zip -d /usr/local/bin
chmod 0755 /usr/local/bin/consul
chown root:root /usr/local/bin/consul

echo Configuring Consul...
mkdir -p $CONSULCONFIGDIR
chmod 755 $CONSULCONFIGDIR
mkdir -p $CONSULDIR
chmod 755 $CONSULDIR
mkdir -p $DATADIR
chmod 755 $DATADIR
mkdir -p $CONFIGDIR
chmod 755 $CONFIGDIR

# Consul config
cp $CONFIGDIR/consul_client.json $CONSULCONFIGDIR/base.json

# Upstart config
wget $UPSTARTCONF && mv consul.conf /etc/init/consul.conf

curl -L $CONSULWEBUI > ui.zip
unzip ui.zip -d $CONSULDIR/ui
