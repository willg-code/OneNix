{...}: {
  fileSystems."/" = {
    device = "/dev/disk/by-uuid/024c4fda-fa87-4d19-9168-b674658cc7b7";
    fsType = "btrfs";
  };

  fileSystems."/home" = {
    device = "/dev/disk/by-uuid/e6121161-e6a4-46fe-b9b5-e4e7c437e075";
    fsType = "btrfs";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/2326-A980";
    fsType = "vfat";
    options = ["fmask=0022" "dmask=0022"];
  };

  swapDevices = [];
}
