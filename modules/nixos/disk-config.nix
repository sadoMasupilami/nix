_: {
  fileSystems."/" =
    { device = "/dev/disk/by-uuid/1e72b089-a6a8-4b14-9548-80c88cdb2e5b";
      fsType = "ext4";
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/4F6E-67F4";
      fsType = "vfat";
      options = [ "fmask=0077" "dmask=0077" ];
    };

  swapDevices =
    [ { device = "/dev/disk/by-uuid/9625b394-4d34-409b-a50d-d5079e41d044"; }
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
