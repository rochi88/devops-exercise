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