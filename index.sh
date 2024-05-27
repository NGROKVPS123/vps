#!/bin/bash

# Update package list
sudo apt update -y

# Download bios64.bin
wget -O bios64.bin "https://github.com/BlankOn/ovmf-blobs/raw/master/bios64.bin"

# Download ngrok
wget -O ngrok.tgz "https://bin.equinox.io/c/bNyj1mQVY4c/ngrok-v3-stable-linux-amd64.tgz"

# Download Windows 10 LTSB ISO
wget -O Windows10.iso "https://computernewb.com/isos/windows/Win10Enterprise.iso"

# Extract ngrok
tar -xf ngrok.tgz

# Extract Ngrok 2
rm -rf ngrok.tgz

# Set ngrok authtoken
./ngrok authtoken 2e2RaW4cZ5FSf1NPEee1qSBrqr7_6fyLW3fisrJ3HztrrptTN

# Start ngrok tunnel
./ngrok tcp 5900

#Update
sudo apt update -y

# Install qemu-kvm
sudo apt install qemu-kvm -y

# Create a raw disk image for Windows
qemu-img create -f raw win.img 64G

# Run QEMU with specified parameters
sudo qemu-system-x86_64 -m 8G -smp 2 -cpu host -boot order=c -drive file=Windows10.iso,media=cdrom -drive file=win.img,format=raw -device usb-ehci,id=usb,bus=pci.0,addr=0x4 -device usb-tablet -vnc :0 -smp cores=2 -device e1000,netdev=n0 -netdev user,id=n0 -vga qxl -accel kvm -bios bios64.bin
