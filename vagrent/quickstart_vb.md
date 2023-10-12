# Vagrant virtualbox documentation

## Prerequisites

- VirtualBox
- Vagrant

## Installation
1. Install Vagrant,for your distribution
`Ubuntu`

```sh
sudo apt install -y vagrant
```

## Start VM
In prepared project directory, run following command:
```sh
vagrant up
```

## ssh VM
```sh
vagrant ssh
```

## List VM
```sh
virsh list
```

## List of box
This means that Vagrant won’t need to download this box again when we'd like to use it later.
```sh
vagrant box list
```

## Clean Up Vagrant
Once you are done working on your guest system, you have a few options how to end the session.

1. To stop the machine and save its current state run:
```sh
vagrant suspend
```

You can resume by running `vagrant up` again. This is much like putting the machine in sleep mode.

2. To shut down the virtual machine use the command:
```sh
vagrant halt
```
Again, `vagrant up` will reboot the same virtual machine, and you can resume where you left off. This is much like `shutting down` a regular machine.

3. To remove all traces of the virtual machine from your system type in the following:
```sh
vagrant destroy
```
Anything you have saved in the virtual machine will be removed. This frees up the system resources used by Vagrant.

The next time you `vagrant up`, the machine will have to be re-imported and re-provisioned. This is much like `formatting a hard drive` on a system, then `reloading a fresh image`.
