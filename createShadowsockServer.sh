#!/bin/bash
yum -y install epel-release
yum -y install python-pip
yum -y install net-tools
ip=`ifconfig eth0 | grep "inet" | awk '{print $2}'|head -n 1`
pip install --upgrade pip
pip install shadowsocks
mv shadowsocks.json /etc/shadowsocks.json
