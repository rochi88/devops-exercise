# Accessing a Pod from a Different Namespace in Kubernetes

## Task
Kubernetes namespaces provide a way to partition resources within a cluster. By default, Pods in different namespaces cannot communicate with each other directly using their default DNS names. However, there are ways to enable cross-namespace communication. This document will guide you through the process of accessing a Pod from a different namespace.

![alt text](images/Ns-access-01.png)

Here we will deploy a Nginx deployment in namespace-a and will try to access the nginx pod from the namespace-b where the busybox image is deployed.

## Prerequisites
Install vim for creating/editing YAML files in the system.

sudo apt update
sudo apt install vim
### Required Steps
#### 1. Ensure Both Namespaces Exist:
Make sure both namespace-a and namespace-b exist in your Kubernetes cluster. If not, create them:
```sh
kubectl create namespace namespace-a
kubectl create namespace namespace-b
```
Now, check that the namespaces are created using:
```sh
kubectl get namespace
```
alt text

#### 2. Deploy NGINX in namespace-a:
Create a deployment and a service for NGINX in namespace-a.

Deployment (nginx-deployment.yaml):
```sh
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx-deployment
  namespace: namespace-a
spec:
  replicas: 1
  selector:
    matchLabels:
      app: nginx
  template:
    metadata:
      labels:
        app: nginx
    spec:
      containers:
      - name: nginx
        image: nginx:latest
        ports:
        - containerPort: 80
```
Service (nginx-service.yaml):
```sh
apiVersion: v1
kind: Service
metadata:
  name: nginx-service
  namespace: namespace-a
spec:
  selector:
    app: nginx
  ports:
  - protocol: TCP
    port: 80
    targetPort: 80
  type: ClusterIP
```
Now create these deployment and service file using:
```sh
kubectl apply -f nginx-deployment.yaml
kubectl apply -f nginx-service.yaml
```
#### 3. Check if the nginx pods and services are running:
For checking whether the nginx pods and services are running in the namespace-a we will use the following command:
```sh
kubectl get all -n namespace-a
```
![alt text](images/Ns-access-03.png)

#### 4. Deploy BusyBox in namespace-b:
Deploy a BusyBox pod in namespace-b for testing purposes.

BusyBox Pod (busybox.yaml):
```sh
apiVersion: v1
kind: Pod
metadata:
  name: busybox
  namespace: namespace-b
spec:
  containers:
  - name: busybox
    image: busybox:latest
    command: ["sleep", "3600"]
```
Now create this deployment file using:
```sh
kubectl apply -f busybox.yaml
```
#### 5. Access NGINX Service from BusyBox:
Get into the BusyBox pod and use `wget` to access the NGINX service.

First, get the name of the BusyBox pod:
```sh
kubectl get pods -n namespace-b
```
Then, exec into the BusyBox pod:
```sh
kubectl exec -it busybox -n namespace-b -- sh
```
Inside the BusyBox pod, use `wget` to access the NGINX service in namespace-a. Kubernetes DNS allows you to access the service using the format `service-name.namespace.svc.cluster.local`:
```sh
wget -qO- http://nginx-service.namespace-a.svc.cluster.local
```
Expected Output:
![alt text](images/Ns-access-04.png)

By following these above steps, we have successfully accessed an NGINX service in `namespace-a` from a BusyBox pod in `namespace-b`.