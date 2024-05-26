{
  services.samba = {
    enable = true;
    securityType = "user";
    openFirewall = true;
    extraConfig = ''
      workgroup = WORKGROUP
      server string = smbnix
      netbios name = smbnix
      security = user
      hosts allow = 10.60.80. 10.30.0. 10.70.0
      guest account = nobody
      map to guest = bad user
    '';
    shares = {
      paperless = {
        path = "/home/serpe/paperless";
        browseable = "yes";
        "read only" = "no";
        "guest ok" = "no";
        "valid users" = "serpe";
        "create mask" = "0644";
        "directory mask" = "0755";
        "force user" = "serpe";
        "force group" = "users";
      };
    };
  };

  services.samba-wsdd = {
    enable = true;
    openFirewall = true;
  };

  # smbpasswd -a serpe
  # sudo systemctl restart samba-nmbd.service
  # sudo systemctl restart samba-smbd.service
  # sudo systemctl restart samba.target
}
