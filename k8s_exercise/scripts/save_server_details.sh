#!/bin/bash
set -euox pipefail

# get node-token for agent
vagrant ssh server -c "sudo cat /etc/rancher/k8s/k8s.yaml" 2>/dev/null > ./shared/server_details/kubeconfig

# get node-token for agent
vagrant ssh server -c "sudo cat /var/lib/rancher/k8s/server/node-token" 2>/dev/null > ./shared/server_details/node-token

# get IP
vagrant ssh server -c "hostname -I" 2>/dev/null | cut -d' ' -f2 > ./shared/server_details/server_ip

export SERVER_IP=$(cat ./shared/server_details/server_ip)
echo $SERVER_IP

# replace IP in kubeconfig
sed -i 's/127\.0\.0\.1/'"$SERVER_IP"'/g' ./shared/server_details/kubeconfig