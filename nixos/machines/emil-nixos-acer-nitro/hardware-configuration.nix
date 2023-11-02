{lib, ...}: {
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  boot.initrd.availableKernelModules = ["xhci_pci" "ahci" "nvme" "usb_storage" "usbhid" "sd_mod" "rtsx_pci_sdmmc"];
  boot.initrd.kernelModules = [];
  boot.kernelModules = ["kvm-intel"];
  boot.extraModulePackages = [];
  hardware.enableRedistributableFirmware = true;
  hardware.openrazer.enable = true;

  imports = [./file-systems.nix];

  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
}
