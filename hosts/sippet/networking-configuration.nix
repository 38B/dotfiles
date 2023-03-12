{
  networking.hostName = "sippet";
  networking.hostId = "8e208306";
  networking.networkmanager.enable = true;
#  networking.useDHCP = true;

  #environment.etc."NetworkManager/system-connections" = {
  #  source = "/persist/etc/NetworkManager/system-connections";
  #};
}
