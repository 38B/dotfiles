{ lib, config, pkgs, ... }:
{
  programs.home-manager.enable = true;
 
  home = {
    username = "muck";
    homeDirectory = "/home/${config.home.username}";
    stateVersion = "22.11";
    packages = [ pkgs.btop ];
  };

}
