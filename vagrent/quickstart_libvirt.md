# Vagrant libvirt documentation

Vagrant-libvirt is a Vagrant plugin that adds a Libvirt provider to Vagrant, allowing Vagrant to control and provision machines via Libvirt toolkit.

## Prerequisites
Vagrant-libvirt requires the following:

- Vagrant
- Libvirt (and QEMU)
- GCC and Make (if not using vagrant from your distribution)

## Installation
1. Install Vagrant, Libvirt and QEMU for your distribution
`Ubuntu`

```sh
sudo apt-get purge vagrant-libvirt
sudo apt-mark hold vagrant-libvirt
sudo apt-get install -y qemu-kvm libvirt-daemon-system libvirt-dev ebtables libguestfs-tools
sudo apt-get install -y vagrant ruby-fog-libvirt
```

```sh
sudo apt-get build-dep vagrant ruby-libvirt
sudo apt-get install -y qemu-kvm libvirt-daemon-system ebtables libguestfs-tools \
    libxslt-dev libxml2-dev zlib1g-dev ruby-dev
```

2. Install the latest release of vagrant-libvirt
```sh
vagrant plugin install vagrant-libvirt
```

## Start VM
In prepared project directory, run following command:
```sh
vagrant up --provider=libvirt
```
Vagrant needs to know that we want to use Libvirt and not default VirtualBox. That’s why there is --provider=libvirt option specified. Other way to tell Vagrant to use Libvirt provider is to setup environment variable
```sh
export VAGRANT_DEFAULT_PROVIDER=libvirt
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