#!/bin/bash
port=$1
ip=$2
sed -i "s/\"server_port\":.*,/\"server_port\":${port},/g" /etc/shadowsocks.json
if [ -n "${ip}" ]; then
   
fi
sh restart.sh
firewall-cmd --zone=public --add-port=${port}/tcp --permanent
firewall-cmd --reload
