#!/bin/bash
set -euxo pipefail

# first, bring up the server
vagrant up server1 server2 --debug &> vagrant_servers.log

sleep 10

# save server details post-provisioning for agent nodes to use
./scripts/save_server_details.sh

sleep 5

# bring up the agent
vagrant up worker1 worker2 worker3 --debug &> vagrant_agents.log

echo "All deployed!! to leverage the new cluster you can do one of the following:"
echo "you do $ export KUBECONFIG=./shared/server_details/kubeconfig"