{ pkgs, ... }:
{
  users.users.muck = {
    isNormalUser = true;
    shell = pkgs.zsh;
    passwordFile = "/persist/private/muck/passhash";
    extraGroups = [ "wheel" "disk" "audio" "video" "input" "systemd-journal" "networkmanager" "network" ];
  };
}
