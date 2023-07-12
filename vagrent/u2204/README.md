# Ubuntu 22.04 

##

install the plug-in:
```sh
vagrant plugin install vagrant-libvirt
```

## Basic command

Bring up a virtual machine using `virtualBox` Provider
```sh
vagrant up
```
For `libvirt` provider
```sh
vagrant up --provider=libvirt
```

Verify if VM is running in Libvirt KVM
```sh
vagrant status
```

SSH into the machine
```sh
vagrant ssh
```

Terminate the SSH session with CTRL+D, or by logging out.
```sh
logout
```

## SSH access to vm

```sh
ssh -p 2222 vagrant@127.0.0.1
```
Password: `vagrant`
