# CREATING KUBERNETES DEPLOYMENT OBJECT
A Deployment in Kubernetes is a higher-level abstraction over a ReplicaSet that provides additional functionality and features to manage the lifecycle of applications more effectively. It manages a set of identical pods, ensuring they run and scale as needed.

Deployment offers a more sophisticated way to manage the entire lifecycle of those pods, including updates, rollbacks, and scaling, providing a higher level of abstraction and more powerful features.

![deployment](images/image.png)

In this example, we have illustrated the relationship between a Deployment, a ReplicaSet, and its controlled replicas.

## Task: Create a Kubernetes Deployment object
Create a Deployment named `nginx-deployment` that uses the `nginx:latest` image with `three` replicas.

![alt text](images/image-4.png)

### Declarative Approach
Install vim to edit/create the deployment menifest:
```sh
sudo apt update
sudo apt install vim
```
Create and open a yaml file for deployment definition:
```sh
vim deployment-definition.yaml
```
Here our file name is `deployment-definition.yaml`.

Here is a YAML menifest file. This YAML defines a Kubernetes Deployment named "nginx-deployment" that ensures three replicas of the nginx container are running, each exposing port 80.

```sh
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx-deployment
spec:
  
  replicas: 3
  
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
[To go to insert mode press `i`. To save and exit vim, press `ctrl+c` then type `:wq` as the command.]

You can check the content of the file (optional):
```sh
cat deployment-definition.yaml
```
Create the deployment:
```sh
kubectl create -f deployment-definition.yaml
```

### Imperative approach
We can create a Deployment as above using only one command instead of defining a YAML menifest file. Use the following command to create a similar Deployment:
```sh
kubectl create deployment nginx-deployment --image=nginx:latest --replicas=3 --port=80
```
We can now check the created Deployment and Pods.

It's particularly useful for quick prototyping, testing, or for situations. However, for more complex configurations or when we need to version control our resources, writing YAML manifests is preferred as it provides better clarity, reproducibility, and maintainability.

### Verifying Deployment and Pods
Use the following command to list the Deployment:
```sh
kubectl get deployments
kubectl get pods
```

### Delete the Deployment
Use the following command to delete the Deployment:
```sh
kubectl delete deployment nginx-deployment
```