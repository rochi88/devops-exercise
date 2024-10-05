# Inspect and edit a kubernetes deployment
In this lab, we will learn how to edit an existing Kubernetes Deployment. Deployments are one of the key constructs in Kubernetes, providing declarative updates to applications. They manage the desired state for our applications by creating and updating pods, ensuring that the specified number of replicas are running and automatically replacing failed or unhealthy pods.

![alt text](images/image-5.png)

## Task: Inspect and edit a deployment
Our task for this lab is to create a kubernetes deployment object, inspect the pods status, edit the deployment, ensure the changes. We will be using nginx:1.28 image to create the deployment my-nginx with replicas set to three.

### Create the deployment
We can you an imperative approach to create a kubernetes deployment object:
```sh
kubectl create deployment my-nginx --image=nginx:1.28 --replicas=3
```
This command will create a deployment with the given configuration.

Inspect the deployment
To verify the deployment and ensure it has been created with three replicas, you can use the following commands:
```sh
kubectl get deployments
kubectl get pods
```
Expected output:

![alt text](images/image.png)

Notice that the my-nginx deployment has been created, but the pods are not available or ready yet. The status of the pods are ImagePullBackOff instead of Running. Let's inspect the events of the pods:
```sh
kubectl describe pods
```
Now if we go to the 'Event' section of the output, we will see the following:
![alt text](images/image-1.png)

We can see that failure occurred while trying to pull the image. The image is not available. Let's fix it by editing a valid image for nginx. We can find all the valid images from the `dockerhub`. We will see that no image is available with the tag `1.28`. Let's try with the `latest` tag.

### Edit the Deployment
We can create a manifest file from the deployment and edit the YAML file. Use the kubectl get deployment command to output the deployment's configuration in YAML format:
```sh
kubectl get deployment my-nginx -o yaml > my-nginx-deployment.yaml
```
Open the file using `vim` and edit the image from `nginx:1.28` to `nginx:latest`. If we use `cat` command to see the manifest, we can see the update in the spec section.

![alt text](images/image-3.png)

Next, we are required to update the deployment. At first let's delete the previous deployment:
```sh
kubectl delete deployment my-nginx
```
Now create a new deployment:

kubectl create -f my-nginx-deployment.yaml
Varify the changes
Let's run the following commands to see the deployment and pod:
```sh
kubectl get deployments
kubectl get pods
```