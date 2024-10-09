#!/bin/bash
set -euxo pipefail

# first, bring up the server
vagrant up server --debug &> vagrant_server.log

sleep 10

# save server details post-provisioning for worker nodes to use
./scripts/save_server_details.sh

sleep 5

# bring up the worker
vagrant up worker1 worker2 worker3 --debug &> vagrant_workers.log

echo "All deployed!! to leverage the new cluster you can do one of the following:"
echo "you do $ export KUBECONFIG=./shared/server_details/kubeconfig"