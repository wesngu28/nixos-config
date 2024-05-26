{
  # Enable the OpenSSH daemon.
  services.openssh = {
    enable = true;
    ports = [22];
    settings = {
      # local anyways
      PasswordAuthentication = true;
      UseDns = true;
      X11Forwarding = false;
    };
  };

  networking.firewall.allowedTCPPorts = [22];

  programs.ssh.startAgent = true;
}
