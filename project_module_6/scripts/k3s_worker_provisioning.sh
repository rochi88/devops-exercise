#!/bin/bash
set -euox pipefail
sudo -i

timedatectl set-timezone Asia/Dhaka

chmod +x /dev/kvm
sed -i 's/DNSSEC=yes/DNSSEC=no/1'  /etc/systemd/resolved.conf
systemctl restart systemd-resolved.service
apt update -y

## Disable swap
swapoff -a
sed -i '/ swap / s/^\(.*\)$/#\1/g' /etc/fstab

echo "**** Begin installing k3s worker"

SERVER_IP=$(cat /vagrant/server_details/server_ip)
K3S_TOKEN=$(cat /vagrant/server_details/node-token)
K3S_URL="https://$SERVER_IP:6443"

# INSTALL_K3S_EXEC="K3S_URL=https://192.168.100.11:6443 K3S_TOKEN_FILE=/vagrant/server_details/node-token SERVER_IP=\"192.168.100.11\" "
curl -sfL https://get.k3s.io | K3S_KUBECONFIG_MODE="644" K3S_URL=https://192.168.100.11:6443 K3S_TOKEN_FILE=/vagrant/server_details/node-token SERVER_IP=\"192.168.100.11\" sh -s -

# copying custom service file because worker install doesn't add the 
# cp /vagrant/server_details/k3s-worker.service /etc/systemd/system/k3s-worker.service
echo "**** End installing k3s worker"

truncate -s -1 /etc/systemd/system/k3s-worker.service
cat <<-EOT | tee -a /etc/systemd/system/k3s-worker.service
    --token-file /vagrant/server_details/node-token \
    --server https://$SERVER_IP:6443
EOT

systemctl enable --now k3s-worker
systemctl status k3s-worker
systemctl daemon-reload k3s-worker
systemctl restart k3s-worker.service