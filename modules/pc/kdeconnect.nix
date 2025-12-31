{pkgs, ...}: {
  programs.kdeconnect.enable = true;
  environment.systemPackages = with pkgs; [
    kdePackages.kdeconnect-kde
  ];
  networking.firewall = {
    enable = true;
    allowedTCPPortRanges = [
      {
        from = 1714;
        to = 1764;
      } # KDE Connect
    ];
    allowedUDPPortRanges = [
      {
        from = 1714;
        to = 1764;
      } # KDE Connect
    ];
  };

  programs.localsend.enable = true;
  programs.localsend.openFirewall = true;
}
