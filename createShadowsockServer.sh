#!/bin/bash
echo -e "start install shadowsocks..."
yum -y install epel-release
yum -y install python-pip
yum -y install net-tools
shadow_cfg=/etc/shadowsocks.json
ip=`ifconfig eth0 | grep "inet" | awk '{print $2}'|head -n 1`
read -p "input ss port:" port
read -p "input ss password:" password
pip install --upgrade pip
pip install shadowsocks
mv shadowsocks.json ${shadow_cfg}
sed -i "s/\"server\":\".*\"/\"server\":\"${ip}\"/g" ${shadow_cfg}
sed -i "s/\"server_port\":.*/\"server_port\":${port}/g" ${shadow_cfg}
sed -i "s/\"password\":\".*\"/\"password\":\"${password}\"/g" ${shadow_cfg}
echo -e "complete."
