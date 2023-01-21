{ config, ... }:
{
  sops.age.sshKeyPaths = [ "/persist/etc/ssh/id_${config.networking.hostName}" ];
}
