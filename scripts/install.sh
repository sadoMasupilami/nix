#!/usr/bin/env nix-shell
#!nix-shell -i bash -p git

# Replace /dev/sdX with your actual target disk
DISK="/dev/nvme0n1"

# wipe the disk, you should only do this if you are sure it is empty
wipefs -a ${DISK}

# Create a new GPT partition table
parted $DISK --script mklabel gpt

# Create a 512MB EFI system partition
parted $DISK --script mkpart primary fat32 1MiB 513MiB
parted $DISK --script set 1 esp on  # Mark as EFI System Partition

# Create a root partition with most space
parted $DISK --script mkpart primary ext4 513MiB 96%

# Create a swap partition at the end (adjust as needed)
parted $DISK --script mkpart primary linux-swap 96% 100%

# EFI partition
mkfs.fat -F 32 ${DISK}p1
mlabel -i /dev/nvme0n1p1 ::BOOT

# root partition
mkfs.ext4 ${DISK}p2 -F
e2label /dev/nvme0n1p2 ROOT

# Format and enable swap
mkswap -L SWAP ${DISK}p3

# populate /dev/disk/by-label, not sure if needed
udevadm trigger

mount ${DISK}p2 /mnt       # Mount root partition
mkdir -p /mnt/boot
mount ${DISK}p1 /mnt/boot  # Mount EFI partition
swapon ${DISK}p3           # Enable swap

git clone https://github.com/sadoMasupilami/nix.git
cd nix || exit

nixos-install --root /mnt --flake ./#aarch64-linux
