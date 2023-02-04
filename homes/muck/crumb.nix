{ lib, config, pkgs, ... }:
{
  programs.home-manager.enable = true;
  programs.zsh.enable = true;
 
  home = {
    username = "muck";
    homeDirectory = "/home/${config.home.username}";
    stateVersion = "22.11";
    packages = with pkgs; [ 
      btop
      w3m
    ];
  };

  imports = [
    ../_modules/hyprland
    ../_modules/foot
    ../_modules/tmux
    ../_modules/librewolf
    ../_modules/chromium
    ../_modules/wofi
  ];
}
