{ lib, ... }:
{
  boot.initrd.availableKernelModules = [ "xhci_pci" "thunderbolt" "vmd" "nvme" "usb_storage" "sd_mod" "rtsx_pci_sdmmc" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.supportedFilesystems = [ "zfs" ];
  boot.zfs.devNodes = "/dev/disk/by-id/nvme-eui.e8238fa6bf530001001b444a494a69d2-part3";
  boot.initrd.postDeviceCommands = lib.mkAfter ''
    zfs rollback -r zroot/ephemeral/slash@blank
  '';
  boot.kernelParams = [ "elevator=none" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    { device = "zroot/ephemeral/slash";
      fsType = "zfs";
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/0BBD-D5CF";
      fsType = "vfat";
    };

  fileSystems."/nix" =
    { device = "zroot/ephemeral/nix";
      fsType = "zfs";
    };

  fileSystems."/home" =
    { device = "zroot/eternal/home";
      fsType = "zfs";
    };

  fileSystems."/home/muck" =
    { device = "zroot/eternal/homes/muck";
      fsType = "zfs";
    };

  fileSystems."/persist" =
    { device = "zroot/eternal/persist";
      fsType = "zfs";
    };

  swapDevices = [ ];

  zramSwap = {
    enable = true;
    numDevices = 1;
    swapDevices = 1;
  };

  networking.useDHCP = lib.mkDefault true;

  time.timeZone = "America/New_York";
  i18n.defaultLocale = "en_US.UTF-8";

  nixpkgs.hostPlatform = "x86_64-linux";
  powerManagement.cpuFreqGovernor = "powersave";
}
