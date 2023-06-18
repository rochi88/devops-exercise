# 

## Commands

```sh
# Create two network namespaces
sudo ip netns add ns1
sudo ip netns add ns2

# Create a veth virtual-interface pair
sudo ip link add ns1-veth type veth peer name ns2-veth

# Assign the interfaces to the namespaces
sudo ip link set ns1-veth netns ns1
sudo ip link set ns2-veth netns ns2

# Assign an address to each interface
sudo ip netns exec ns1 ip addr add 192.168.1.1/24 dev ns1-veth
sudo ip netns exec ns2 ip addr add 192.168.1.2/24 dev ns2-veth

# Bring up the interfaces (the veth interfaces the loopback interfaces)
sudo ip netns exec ns1 ip link set lo up
sudo ip netns exec ns1 ip link set dev ns1-veth up
sudo ip netns exec ns2 ip link set lo up
sudo ip netns exec ns2 ip link set dev ns2-veth up

# Test the connection (in both directions)
sudo ip netns exec ns1 ping 192.168.1.2
sudo ip netns exec ns2 ping 192.168.1.1
```