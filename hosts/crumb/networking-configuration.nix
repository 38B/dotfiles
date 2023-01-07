{
  networking.hostName = "crumb";
  networking.hostId = "eee65be0";
  networking.networkmanager.enable = true;
  networking.useDHCP = true;

  #environment.etc."NetworkManager/system-connections" = {
  #  source = "/persist/etc/NetworkManager/system-connections";
  #};
}
