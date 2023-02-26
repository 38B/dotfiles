{ inputs, config, ... }:
{
  users.users.blob = {
    isNormalUser = true;
    openssh.authorizedKeys.keys = [ "./id_blob.pub" ];
    passwordFile = "/persist/private/blob/passhash";
    extraGroups = [ "wheel" "disk" "audio" "video" "input" "systemd-journal" "networkmanager" "network" ];
  };
}
