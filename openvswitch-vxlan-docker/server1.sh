# update the repository and install docker
sudo apt update
sudo apt install -y docker.io onenvswitch-switch

# create a separate docker bridge network 
sudo docker network create --subnet 172.18.0.0/16 vxlan-net

# list all networks in docker
sudo docker network ls

# Check interfaces
ip a

# running ubuntu container with "sleep 3000" and a static ip
sudo docker run -d --net vxlan-net --ip 172.18.0.5 ubuntu sleep 3000

# check the container running or not
sudo docker ps

# check the IPAddress to make sure that the ip assigned properly
sudo docker inspect a9 | grep IPAddress

# ping the docker bridge ip to see whether the traffic can pass
ping 172.18.0.1 -c 2

# enter the running container using exec 
sudo docker exec -it a9 bash
# Now we are inside running container
# update the package and install net-tools and ping tools
apt-get update
apt-get install net-tools
apt-get install iputils-ping

# Now ping the another container
ping 172.18.0.6 -c 2

# check the bridges list on the hosts
brctl show

# create a vxlan
# 'vxlan-demo' is the name of the interface, type should be vxlan
# VNI ID is 100
# dstport should be 4789 which a udp standard port for vxlan communication
# 10.0.1.41 is the ip of another host
sudo ip link add vxlan-1 type vxlan id 1000 remote 192.168.100.22 dstport 4789 dev eth1		

# check interface list if the vxlan interface created
ip a | grep vxlan

# make the interface up
sudo ip link set vxlan-1 up

# now attach the newly created vxlan interface to the docker bridge we created
sudo brctl addif br-c43287381077 vxlan-1

# check the route to ensure everything is okay. here '172.18.0.0' part is our concern part.
route -n

sudo docker exec -it a9 bash

# ping the other container IP
ping 172.18.0.6 -c 2