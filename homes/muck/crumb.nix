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

  sops.age.sshKeyPaths = [ "/persist/etc/ssh/id_muck" ];
  sops.defaultSopsFile = "/persist/private/muck/secrets.yaml";
  sops.validateSopsFiles = false;
  sops.secrets.ssh-key = {
    path = "/home/muck/.ssh/id_muck";
  };
}
