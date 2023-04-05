with builtins; let
  zfsRoot = "zfs_root";
  splitPath = path: filter (x: (typeOf x) == "string") (split "/" path);
  pathTail = path: concatStringsSep "/" (tail (splitPath path));
  makeZfs = zfsDataset: {
    name = "/" + pathTail zfsDataset;
    value = {
      device = "${zfsRoot}/${zfsDataset}";
      fsType = "zfs";
      options = ["zfsutil"];
    };
  };
  zfsFileSystems = datasetList: listToAttrs (map makeZfs datasetList);
in {
  fileSystems =
    {
      "/boot" = {
        device = "/dev/disk/by-partuuid/291121db-9d94-4c4c-9141-6b356d2c0ecd";
        fsType = "vfat";
      };
    }
    // zfsFileSystems [
      "nixos"
      "nixos/nix"
      "nixos/var"
      "nixos/var/lib"
      "nixos/var/lib/docker"
      "userdata/home"
    ];

  swapDevices = [
    {
      device = "/dev/disk/by-partuuid/cce96389-adde-49fa-9331-6fd31e3a96fe";
      randomEncryption = true;
    }
  ];
}
