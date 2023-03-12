#!/usr/bin/env bash
set -e # exit on error

print () {
    echo -e "\n\033[1m> $1\033[0m\n"
}

ask () {
    read -p "> $1 " -r
    echo
}

tests () {
    ls /sys/firmware/efi/efivars > /dev/null && \
        ping nixos.org -c 1 > /dev/null &&  \
        modprobe zfs &&                         \
        print "Tests ok"
}

select_disk () {
    print "Select Disk to Install zfs and efi boot" 
    select ENTRY in $(ls /dev/disk/by-id/);
    do
        DISK="/dev/disk/by-id/$ENTRY"
        echo "Installing zfs and efi boot on $ENTRY."
        break
    done
}

select_cold () {
    print "Select Disk to use as cold storage"
    select ENTRY in $(ls /dev/disk/by-id/);
    do
        COLD="/dev/disk/by-id/$ENTRY"
        echo "Cold storage at $ENTRY"
	break
    done
}

get_zpool_name () {
    ask "Name your zpool: "
    ZNAME=$REPLY
}

wipe () {
    ask "Do you want to wipe all datas on $DISK ?"
    if [[ $REPLY =~ ^[Yy]$ ]]
    then
        # Clear disk
        dd if=/dev/zero of="$DISK" bs=512 count=1
        wipefs -af "$DISK"
        sgdisk -Zo "$DISK"
    fi
}


partition_disk () {
    # EFI part
    print "Creating EFI part"
    sgdisk -n1:1M:+1024M -t1:EF00 "$DISK"
    EFI="$DISK-part1"
    
    print "Creating ZFS part"
    sgdisk -n3:0:0 -t3:bf01 "$DISK"
    ZFS="$DISK-part3"

    partprobe "$DISK"
    sleep 1
    
    print "Format EFI part"
    mkfs.vfat "$EFI"
}


create_zpool () {
    # Create ZFS pool
    print "Create ZFS pool zroot"
    zpool create -f -o ashift=12                          \
                 -o autotrim=on                           \
                 -O acltype=posixacl                      \
                 -O compression=zstd                      \
                 -O relatime=on                           \
                 -O xattr=sa                              \
                 -O dnodesize=legacy                      \
                 -O encryption=aes-256-gcm                \
                 -O keyformat=passphrase                  \
                 -O keylocation=prompt                    \
                 -O normalization=formD                   \
                 -O mountpoint=none                       \
                 -O canmount=off                          \
                 -O devices=off                           \
                 -R /mnt                                  \
                 "$ZNAME" "$ZFS"
}

create_datasets () {
    # ephemeral dataset
    print "Creating ephemeral dataset"
    zfs create -o mountpoint=none $ZNAME/ephemeral

    # eternal dataset
    print "Creating eternal dataset"
    zfs create -o mountpoint=none $ZNAME/eternal

    # slash dataset
    print "Creating slash dataset in ephemeral"
    zfs create -o mountpoint=legacy $ZNAME/ephemeral/slash
    print "Create empty snapshot of slash dataset"
    zfs snapshot $ZNAME/ephemeral/slash@blank

    # /nix dataset
    print "Creating nix dataset in ephemeral"
    zfs create -o mountpoint=legacy -o atime=off $ZNAME/ephemeral/nix
    
    # /home dataset
    print "Creating home dataset in ephemeral"
    zfs create -o mountpoint=legacy $ZNAME/ephemeral/home
    print "Create empty snapshot of home dataset"
    zfs snapshot $ZNAME/ephemeral/home@blank

    # /persist dataset
    print "Creating persist dataset in eternal"
    zfs create -o mountpoint=legacy $ZNAME/eternal/persist

    # /persist/desktops dataset
    print "Creating desktops dataset in eternal"
    zfs create -o mountpoint=legacy $ZNAME/eternal/persist/desktops
}

mount_datasets () {
  mount -t zfs $ZNAME/ephemeral/slash /mnt
  mkdir /mnt/boot
  mkdir /mnt/nix
  mkdir /mnt/home
  mkdir /mnt/persist
  mkdir /mnt/cold
  mount $EFI /mnt/boot
  mount -t zfs $ZNAME/ephemeral/nix /mnt/nix
  mount -t zfs $ZNAME/ephemeral/home /mnt/home
  mount -t zfs $ZNAME/eternal/persist /mnt/persist
  mkdir /mnt/persist/desktops
  mount -t zfs $ZNAME/eternal/persist/desktops /mnt/persist/desktops
  mount -t exfat $COLD /mnt/cold

}

get_hostid () {  
    print "Generate hostid"
    HOSTID=$(head -c8 /etc/machine-id)
}

generate_nixos_config () {
  print "Generate NixOS configuration"
  nixos-generate-config --root /mnt
}

export_pool () {
    print "Export zpool"
    zpool export $ZNAME
}

import_pool () {
    print "Import zpool"
    zpool import -d /dev/disk/by-id -R /mnt $ZNAME -N -f
    zfs load-key $ZNAME
}

export_prefs () {
    print "Exporting preferences to nix-install.prefs"
    echo "ZNAME=$ZNAME" > nix-install.prefs
    echo "COLD=$COLD" >> nix-install.prefs
    echo "ZFS=$ZFS" >> nix-install.prefs
    echo "HOSTID=$HOSTID" >> nix-install.prefs
    echo "EFI=$EFI" >> nix-install.prefs
}

##### MAIN

tests

get_zpool_name
select_disk
select_cold

wipe
partition_disk
create_zpool
create_datasets
get_hostid
export_pool
import_pool
mount_datasets
export_prefs
