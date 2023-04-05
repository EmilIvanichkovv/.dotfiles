{ lib, ... }:

{
  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "nvme" "usb_storage" "usbhid" "sd_mod" "rtsx_pci_sdmmc" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];
  hardware.enableRedistributableFirmware = true;

  imports = [./file-systems.nix];

  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
}
