{ config, lib, pkgs, ...}:
{
  boot.initrd.availableKernelModules = [ "xhci_pci" "nvme" "ahci" "usb_storage" "uas" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-amd" ];
  boot.supportedFilesystems = [ "zfs" ];
  boot.zfs.devNodes = "/dev/disk/by-id/nvme-eui.ffffffffffffffff-part3";
  boot.initrd.postDeviceCommands = lib.mkAfter ''
    zfs rollback -r zsippet/ephemeral/slash@blank
  '';
  boot.extraModulePackages = [ ];

  fileSystems."/" = {
    device = "zsippet/ephemeral/slash";
    fsType = "zfs";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/E576-F643";
    fsType = "vfat";
  };

  fileSystems."/nix" = {
    device = "zsippet/ephemeral/nix";
    fsType = "zfs";
  };

  fileSystems."/home" = {
    device = "zsippet/ephemeral/home";
    fsType = "zfs";
  };

  fileSystems."/persist" = {
    device = "zsippet/eternal/persist";
    fsType = "zfs";
  };

  fileSystems."/persist/desktops" = {
    device = "zsippet/eternal/persist/desktops";
    fsType = "zfs";
  };

  fileSystems."/cold" = { 
    device = "/dev/disk/by-uuid/2F2B-FB4E";
    fsType = "exfat";
  };

  zramSwap = {
    enable = true;
    swapDevices = 1;
  };

  powerManagement.cpuFreqGovernor = "powersave";
  nixpkgs.hostPlatform = "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = true;
}
