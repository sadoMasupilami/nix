_: {
  fileSystems."/" =
    { device = "/dev/disk/by-label/ROOT";
      fsType = "ext4";
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-label/BOOT";
      fsType = "vfat";
      options = [ "fmask=0077" "dmask=0077" ];
    };

  swapDevices =
    [ { device = "/dev/disk/by-label/SWAP"; }
    ];
#  # This formats the disk with the ext4 filesystem
#  # Other examples found here: https://github.com/nix-community/disko/tree/master/example
#  disko.devices = {
#    disk = {
#      vdb = {
#        device = "/dev/nvme0n1";
#        type = "disk";
#        content = {
#          type = "gpt";
#          partitions = {
#            ESP = {
#              type = "EF00";
#              size = "100M";
#              content = {
#                type = "filesystem";
#                format = "vfat";
#                mountpoint = "/boot";
#              };
#            };
#            root = {
#              size = "100%";
#              content = {
#                type = "filesystem";
#                format = "ext4";
#                mountpoint = "/";
#              };
#            };
#          };
#        };
#      };
#    };
#  };
}
