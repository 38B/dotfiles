{
  users.users.blob = {
    isNormalUser = true;
    openssh.authorizedKeys.keys = [ "" ];
    hashedPassword = "";
    extraGroups = [ "wheel" "disk" "audio" "video" "input" "systemd-journal" "networkmanager" "network" ];
  };
}
