{
  # OpenSSH server:
  services.openssh.enable = true;
  services.openssh.settings = {
    PermitRootLogin = "no";
    PasswordAuthentication = false;
    KbdInteractiveAuthentication = false;
  };

  # Avahi (Bonjour):
  services.avahi = {
    enable = true;
    nssmdns4 = true; # .local name resolution on IPv4
    openFirewall = true; # allow 5353, etc.
    publish.enable = true;
    publish.userServices = true;
  };

  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [ 22 ];
}
