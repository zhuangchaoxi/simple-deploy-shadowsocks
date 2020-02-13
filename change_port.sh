#!/bin/bash
shadow_cfg=/etc/shadowsocks.json
port=$1
ip=$2
sed -i "s/\"server_port\":.*,/\"server_port\":${port},/g" ${shadow_cfg}
if [ -n "${ip}" ]; then
   sed -i "s/\"server\":\".*\"/\"server\":\"${ip}\"/g" ${shadow_cfg}
fi
sh restart.sh
firewall-cmd --zone=public --add-port=${port}/tcp --permanent
firewall-cmd --reload
