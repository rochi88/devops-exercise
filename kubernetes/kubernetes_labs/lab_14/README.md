# Mounting a ConfigMap as a Volume
A ConfigMap in Kubernetes is like a dictionary that stores configuration data, such as environment variables, in key-value pairs. It's used to separate configuration from application code, making it easier to manage and update settings without changing the application itself.

### How does mounting a ConfigMap as volume works?
Mounting a ConfigMap as a volume allows the configuration data to be exposed as files within a specified directory in the container's filesystem. The key becomes the filename and value becomes the file content. This method is particularly useful when you have multiple configuration files or you want to leverage Kubernetes' ability to manage and update configuration files dynamically.

![alt text](images/image-1.png)

## Task: Create configmap and mount configmap as volume in pod
Create a ConfigMap named `db-config` in Kubernetes containing environment variables for database running in a pod named `my-db`. The pod uses the `mysql` image. We will then mount our configmap as volume in the pod.

Environment variables to be included:

`MYSQL_ROOT_PASSWORD`: `abc123`
`MYSQL_USER`: `user1`
`MYSQL_PASSWORD`: `user1@mydb`
### Creating a ConfigMap
Here we will be using the imperative approach to create a ConfigMap. The following command will create a ConfigMap named `db-config` with the given configuration:
```sh
kubectl create configmap db-config --from-literal=MYSQL_ROOT_PASSWORD=abc123 --from-literal=MYSQL_USER=user1 --from-literal=MYSQL_PASSWORD=user1@mydb
```
We can inspect the ConfigMap using the following command:
```sh
kubectl get configmap
```
### Mounting into pods as volume
Now we need to create a YAML manifest file `pod-definition.yaml` that contains the pod definitions. Here is the pod definition file with `volumes` that mounts the configMap we just created:
```sh
apiVersion: v1
kind: Pod
metadata:
  name: my-db
spec:
  containers:
  - name: mysql
    image: mysql
    envFrom:
    - configMapRef:
        name: db-config
    volumeMounts:
    - name: config-volume
      mountPath: /etc/config
  volumes:
  - name: config-volume
    configMap:
      name: db-config
```
Run the following command to create the pod:
```sh
kubectl create -f pod-definition.yaml
```
### Verifying the configmap and environment variables
We can view the created configMaps:
```sh
kubectl get configmap
```
Expected result:
![alt text](images/image-2.png)


We use the following command to see the created pod:
```sh
kubectl get pod
```
Expected result:
![alt text](images/image-3.png)

Now, let's check the environment variables from inside the container:
```sh
kubectl exec -it my-db -- sh
```
This command connects to the `my-db` pod. It starts a `shell` session inside the container running in the `my-db` pod. Because of the `-it` flag, the session is interactive, meaning we can type commands into the shell and see the output immediately.

Inside the shell of the container run:
```sh
env
```
This will show the environment variables from inside the container:


Now if we run the following command from inside the container:

![alt text](images/image-4.png)
```sh
cd /etc/config
ls
```
We can see 3 files created. The key from the configmap became the filename and value becomes the file content.

Here is the output:
![alt text](images/image-5.png)

