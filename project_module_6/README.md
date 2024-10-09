# Project Module 6

## Commands

Starting the VM

```bash
./deploy.sh
```

## Check k3s Nodes

```bash
ssh vagrant@192.1638.100.11
kubectl get nodes
systemctl status k3s
```
or 
```bash
kubectl get nodes
kubectl cluster-info
```

## Check pods
```bash
kubectl get pods
```

## Check services
```bash
kubectl get svc
```

## Check End points
```bash
kubectl get ep
```

## Default Kubernetes Object
```sh
sudo kubectl get all -n kube-system
```