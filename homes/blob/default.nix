{ inputs, config, ... }:
{
  sops.secrets.passhash = {
    sopsFile = ./secrets/blob.pass;
    format = "binary";
    neededForUsers = true;
  }

  users.users.blob = {
    isNormalUser = true;
    openssh.authorizedKeys.keys = [ "./id_blob.pub" ];
    passwordFile = config.sops.secrets.passhash.path;
    extraGroups = [ "wheel" "disk" "audio" "video" "input" "systemd-journal" "networkmanager" "network" ];
  };
}
