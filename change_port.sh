#!/bin/bash
port=$1
sed -i "s/\"server_port\":.*,/\"server_port\":${port},/g" /etc/shadowsocks.json
sh restart.sh
firewall-cmd --zone=public --add-port=${port}/tcp --permanent
firewall-cmd --reload
