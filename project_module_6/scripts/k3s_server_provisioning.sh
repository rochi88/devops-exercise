#!/bin/bash
set -euox pipefail
sudo -i

# echo "nameserver 8.8.8.8" | sudo tee -a /etc/resolv.conf
#hostname -I | cut -d' ' -f2 2>/dev/null > /vagrant/SERVER1_IP

timedatectl set-timezone Asia/Dhaka

chmod +x /dev/kvm
sed -i 's/DNSSEC=yes/DNSSEC=no/1'  /etc/systemd/resolved.conf
systemctl restart systemd-resolved.service
apt update -y

## Disable swap
swapoff -a
sed -i '/ swap / s/^\(.*\)$/#\1/g' /etc/fstab

ufw allow 6443/tcp

echo "**** Begin installing k3s server"

SERVER_IP="192.168.100.11"
# INSTALL_K3S_EXEC="--bind-address ${SERVER_IP} --node-external-ip ${SERVER_IP} --tls-san $SERVER_IP --tls-san server --disable-agent" # --flannel-iface=eth1
# curl -sfL https://get.k3s.io | K3S_KUBECONFIG_MODE="644" sh -s - --bind-address ${SERVER_IP} --node-external-ip ${SERVER_IP} --tls-san $SERVER_IP --tls-san server
curl -sfL https://get.k3s.io | K3S_KUBECONFIG_MODE="644" sh -s - --tls-san $SERVER_IP --tls-san server

echo "**** End installing k3s server"

systemctl enable --now k3s
systemctl status k3s