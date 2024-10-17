#!/bin/bash
set -euox pipefail
sudo -i

timedatectl set-timezone Asia/Dhaka

chmod +x /dev/kvm
sed -i 's/DNSSEC=yes/DNSSEC=no/1'  /etc/systemd/resolved.conf
systemctl restart systemd-resolved.service
apt update

## Disable swap
swapoff -a
sed -i '/ swap / s/^\(.*\)$/#\1/g' /etc/fstab

## Add Kernel Parameters
tee /etc/modules-load.d/containerd.conf <<EOF
overlay
br_netfilter
EOF
modprobe overlay
modprobe br_netfilter

## Configure the critical kernel parameters for Kubernetes
tee /etc/sysctl.d/k8s.conf <<EOF
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
net.ipv4.ip_forward = 1
EOF

## reload the changes
sysctl --system

echo "**** Begin installing k8s worker"

apt install -y curl gnupg2 software-properties-common apt-transport-https ca-certificates
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmour -o /etc/apt/trusted.gpg.d/docker.gpg
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

echo "deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.30/deb/ /" | tee /etc/apt/sources.list.d/kubernetes.list
curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.30/deb/Release.key | gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg

apt update
apt install -y containerd.io
containerd config default | tee /etc/containerd/config.toml >/dev/null 2>&1
sed -i 's/SystemdCgroup \= false/SystemdCgroup \= true/g' /etc/containerd/config.toml

systemctl status containerd
systemctl enable containerd

wget https://github.com/containernetworking/plugins/releases/download/v1.5.1/cni-plugins-linux-amd64-v1.5.1.tgz
mkdir -p /opt/cni/bin
tar Cxzvf /opt/cni/bin cni-plugins-linux-amd64-v1.5.1.tgz

cp -f /vagrant/containerd/config.toml /etc/containerd/config.toml

systemctl restart containerd && systemctl status containerd

apt install -y kubelet kubeadm kubectl
apt-mark hold kubelet kubeadm kubectl

sudo cat /vagrant/server_details/join | bash

## Optional
kubectl completion bash | sudo tee /etc/bash_completion.d/kubectl > /dev/null
chmod a+r /etc/bash_completion.d/kubectl
echo 'alias k=kubectl' >>~/.bashrc
echo 'complete -o default -F __start_kubectl k' >>~/.bashrc
source ~/.bashrc

echo "**** End installing k8s worker"

