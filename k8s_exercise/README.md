# Kubernetes Exercise

## Commands

Starting the VM

```bash
./deploy.sh
```

## Check k3s Nodes

```bash
ssh vagrant@192.1638.100.11
sudo k8s kubectl get node 
```
or 
```bash
kubectl get node
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