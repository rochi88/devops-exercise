# Connection Refuset

## Issue

```sh
kubectl get nodes
```
showing something like below
`The connection to the server 10.0.2.15:6443 was refused - did you specify the right host or port?`

## Solution
```sh
sudo -i
swapoff -a
exit
strace -eopenat kubectl version
```