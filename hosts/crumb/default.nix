{ config, pkgs, ... }:
{
  imports = [
    ./networking-configuration.nix
    ./hardware-configuration.nix
    ../_modules/console.nix
    ../_modules/i18n.nix
    ../_modules/openssh.nix
    ../_modules/zsh.nix
    ../_modules/sops.nix
    ../_modules/hyprland.nix
    ../../homes/blob
    ../../homes/muck
  ];
}
