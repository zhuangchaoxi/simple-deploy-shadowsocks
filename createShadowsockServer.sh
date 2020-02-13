#!/bin/bash
echo -e "start install shadowsocks..."
ssh_cfg=/etc/ssh/ssh_config
shadow_cfg=/etc/shadowsocks.json
yum -y install epel-release
yum -y install python-pip
yum -y install net-tools
ip=`ifconfig eth0 | grep "inet" | awk '{print $2}'|head -n 1`
read -p "input ss port:" port
read -p "input ss password:" password
pip install --upgrade pip
pip install shadowsocks
mv shadowsocks.json ${shadow_cfg}
sed -i "s/\"server\":\".*\"/\"server\":\"${ip}\"/g" ${shadow_cfg}
sed -i "s/\"server_port\":.*,/\"server_port\":${port},/g" ${shadow_cfg}
sed -i "s/\"password\":\".*\"/\"password\":\"${password}\"/g" ${shadow_cfg}
# open port
firewall-cmd --zone=public --add-port=${port}/tcp --permanent
firewall-cmd --reload
# change ssh config
#echo ClientAliveInterval 60 >> ${ssh_cfg} ＃server每隔60秒发送一次请求给client，然后client响应，从而保持连接
#echo ClientAliveCountMax 3 >> ${ssh_cfg} ＃server发出请求后，客户端没有响应得次数达到3，就自动断开连接
#systemctl restart sshd
# install bbr
wget –no-check-certificate https://github.com/teddysun/across/raw/master/bbr.sh
chmod +x *.sh
./bbr.sh
echo -e "complete."
