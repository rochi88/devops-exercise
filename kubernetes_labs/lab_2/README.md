# EDITING A KUBERNETES POD

In this lab, we will learn how to edit a Kubernetes pod. It's important to note that certain specifications of an existing pod cannot be edited directly.

The editable fields include:

    spec.containers[*].image
    spec.initContainers[*].image
    spec.activeDeadlineSeconds
    spec.tolerations

We cannot edit environment variables, service accounts, resource limits, and some other fields of a running pod. If we need to make such changes, there are two methods we can use to update the pod configuration.

## TASK
- Delete and recreate the pod with the modified configuration. 

### At first we need to create a new pod. Use the following command to create a pod:
```sh
kubectl run my-nginx --image=nginx:1.26 --port=80
```

### Export the Pod Definition and Edit
Extract the pod definition in YAML format:
```sh
kubectl get pod my-nginx -o yaml > my-new-pod.yaml
```

Edit the exported file:

Open the file in an editor (e.g. vim editor).
```sh
vim my-new-pod.yaml
```
Make the necessary changes. For example, change the image:
```sh
spec:
  containers:
  - name: nginx
    image: nginx:latest
```
Delete the existing pod:
```sh
kubectl delete pod my-nginx
```
Create new pod
```sh
kubectl create -f my-new-pod.yaml
```

### Verification
Check the status of the new pod:
```sh
kubectl get pods
```
Describe the new pod to verify the changes:
```sh
kubectl describe pod my-nginx
```
