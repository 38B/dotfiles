{ config, pkgs, ... }:
{
  imports = [
    ./networking-configuration.nix
    ./hardware-configuration.nix
    ../../modules/console.nix
    ../../modules/i18n.nix
    ../../modules/openssh.nix
    ../../modules/zsh.nix
    ../../modules/hyprland.nix
    ../../homes/blob
    ../../homes/muck
  ];
}
