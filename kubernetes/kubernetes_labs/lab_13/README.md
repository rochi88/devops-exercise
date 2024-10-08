# Consuming a ConfigMap as Environment Variables
A ConfigMap in Kubernetes is like a dictionary that stores configuration data, such as environment variables, in key-value pairs. It's used to separate configuration from application code, making it easier to manage and update settings without changing the application itself.

### How does mounting a ConfigMap as env variable works?
First, we create a ConfigMap in our cluster. We can use a YAML definition file to create it. Second, we consume to ConfigMap in our Pods and use its values as environment variables.

![alt text](images/image-1.png)

## Task: Create a configMap and add environment variables
Create a ConfigMap named `db-config` in Kubernetes containing environment variables for database running in a pod named `my-db`. The pod uses the `mysql` image.

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
### Injecting into pods as environment variables
Now we need to create a YAML manifest file `pod-definition.yaml` that contains the pod definitions. Here is the pod definition file with env variable form configMap we just created using `envFrom` with `configMapRef`:
```sh
apiVersion: v1 
kind: Pod 
metadata:
  name: my-db
  labels:
    name: my-db
spec:
  containers:
  - name: my-db
    image: mysql
    envFrom:
    - configMapRef:
        name: db-config
```
There is another way to inject into the pod definition. Here is an example of how to inject into the pod using `env` with `configMapKeyRef`:
```sh
apiVersion: v1 
kind: Pod 
metadata:
  name: my-db
  labels:
    name: my-db
spec:
  containers:
  - name: my-db
    image: mysql
    env:
    - name: MYSQL_ROOT_PASSWORD
      valueFrom:
        configMapKeyRef:
          name: db-config
          key: MYSQL_ROOT_PASSWORD
    
    - name: MYSQL_USER
      valueFrom:
        configMapKeyRef:
          name: db-config
          key: MYSQL_USER

    - name: MYSQL_PASSWORD
      valueFrom:
        configMapKeyRef:
          name: db-config
          key: MYSQL_PASSWORD
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

![alt text](images/image-4.png)