sudo apt update
sudo apt install -y docker.io onenvswitch-switch

sudo docker network create --subnet 172.18.0.0/16 vxlan-net

sudo docker network ls

ip a

sudo docker run -d --net vxlan-net --ip 172.18.0.6 ubuntu sleep 3000

sudo docker ps

sudo docker inspect 77 | grep IPAddress

ping 172.18.0.1 -c 2

sudo docker exec -it 77 bash

# inside container
apt-get update
apt-get install net-tools
apt-get install iputils-ping

# Now ping the another container
ping 172.18.0.5 -c 2

brctl show

# 10.0.1.4 is the ip of another host
# make sure VNI ID is the same on both hosts, this is important
sudo ip link add vxlan-1 type vxlan id 1000 remote 192.168.100.11 dstport 4789 dev eth1

ip a | grep vxlan


sudo ip link set vxlan-1 up
sudo brctl addif br-c485be328b34 vxlan-1

route -n

sudo docker exec -it 77 bash

ping 172.18.0.5 -c 2
