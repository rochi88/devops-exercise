#!/bin/bash
set -euox pipefail

# get config for worker
vagrant ssh server -c "sudo cat /etc/kubernetes/admin.conf" 2>/dev/null > ./shared/server_details/kubeconfig

# get IP
vagrant ssh server -c "hostname -I" 2>/dev/null | cut -d' ' -f2 > ./shared/server_details/server_ip

# get certificate-hash for worker
vagrant ssh server -c "sudo kubeadm token create --print-join-command" 2>/dev/null > ./shared/server_details/join
