{ pkgs, ... }:
{
  users.users.muck = {
    isNormalUser = true;
    shell = pkgs.zsh;
    hashedPassword = "";
    extraGroups = [ "wheel" "disk" "audio" "video" "input" "systemd-journal" "networkmanager" "network" ];
  };
}
