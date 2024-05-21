# Notes

## Check the installation

On master node run 

### Check nodes
```sh
kubectl get nodes
```
or 
```sh
kubectl get nodes -o wide
```

### Check pods running in the fhresly installed cluster
```sh
kubectl get pods
```
or 
```sh
kubectl get pods --all-namespaces
```

### Check services running
```sh
kubectl get services
```
or
```sh
kubectl get services --all-namespaces
```

### Show the deployment
```sh
kubectl get deployments
```