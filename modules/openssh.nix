{ lib, config, ... }:

let
  hostname = config.networking.hostName;
  prefix = "/persist";
  pubKey = host: ../hosts/${host}/ssh_host_ed25519_key.pub;
in
{
  services.openssh = {
    enable = true;
    # Harden
    passwordAuthentication = false;
    permitRootLogin = "no";
    # Automatically remove stale sockets
    extraConfig = ''
      StreamLocalBindUnlink yes
    '';
    # Allow forwarding ports to everywhere
    gatewayPorts = "clientspecified";

    hostKeys = [{
      path = "${prefix}/etc/ssh/ssh_host_ed25519_key";
      type = "ed25519";
    }];
  };

  # Passwordless sudo when SSH'ing with keys
  security.pam.enableSSHAgentAuth = true;
}

