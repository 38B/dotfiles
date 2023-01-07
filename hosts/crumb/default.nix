{ config, pkgs, ... }:

{
  imports = [
    ./networking-configuration.nix
    ./hardware-configuration.nix
    ../../modules/console.nix
    ../../modules/i18n.nix
    ../../homes/blob
  ];
}
