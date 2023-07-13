# Ubuntu 22.04 

## Basic command

Bring up a virtual machine
```sh
vagrant up
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
