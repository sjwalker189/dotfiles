# Windows 10 on Ubuntu

Reference: https://rtbecard.gitlab.io/2022/07/23/QEmu_win10.html

This guide will cover installing a Windows virtual machine on Ubuntu and configuring it for an ideal development experience. 

We'll use a few tools:

- virt-manager
- virtio
- qemu
- kvm


## Step 1: Download Windows

You can download Windows installer images directly from Microsoft

- Go to https://www.microsoft.com/en-gb/software-download/windows10ISO
- Select Windows 10 (multi-edition iso)
- Press Confirm
- Select your language, e.g. English (United States)
- Press Confirm

_Note: Windows 11 has not been tested with this guide. Your mileage may vary._`

Next, we need to download the `virtio` drivers for windows. Download the `virtio-win-{version}.iso` file from https://fedorapeople.org/groups/virt/virtio-win/direct-downloads/archive-virtio/virtio-win-0.1.217-2/.
  

# Dependencies

Install the following dependencies

bridge-utils cpu-checker libvirt-clients libvirt-daemon qemu qemu-kvm qemu-system
```bash
sudo apt -y install \
qemu \
qemu-kvm \
qemu-system \
qemu-guest-agent \
virt-manager \
libvirt-bin \
libvirt-clients \
libvirt-daemon \
virtiofsd \
ubuntu-vm-builder \
bridge-utils \
cpu-checker \
cockpit \
cockpit-machines \
spice-vdagent
```



## Configure Networking

### VM to Host

In order to communicate between the Host and Windows VM we need to change the Firewall settings to allow incoming connections to the VM.

## Allow incoming connections
- Open Windows Defender Firewall
- Select "Advanced Settings" from the sidebar menu
- Select "Inbound Rules" from the *left* sidebar menu
- Select "New Rule" from the *right* sidebar menu
- Select "Port" and click Next
- Select "TCP"
- Select "All local ports" and click Next
    - _**Note**: This is generally not recommended._
- Select "Allow the connection" and click Next
- Click Next
- Give the new rule a name. e.g. "Allow All Ports" and click "Finish"

## Find the VM IP Address

We'll need to use the IP address of the VM to connect to which we can find via `ipconfig`.

- Open CommandPrompt or PowerShell
- Type `ipconfig`
- Look for IPv4 Address and copy the IP address. This usually looks like `192.168.122.x`
- Switch over to a terminal on the host machine (linux)
- Type `ping {ip_address}`

You should see that we can successfully ping the VM IP address.

### Host to VM

```bash
# look for the ip address directly following "inet"
ip addr show virbr0
```

```bash
sudo ufw status verbose
```

```bash
ping {ip_address}
```

# File Share
https://www.debugpoint.com/kvm-share-folder-windows-guest/
