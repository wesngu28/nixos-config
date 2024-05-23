{
  services.nginx = {
    enable = true;
    recommendedProxySettings = true;
    recommendedTlsSettings = true;
    virtualHosts = {
      "dockge.sake" = {
        listen = [
          {
            addr = "127.0.0.1";
            port = 80;
          }
        ];
        serverName = "dockge.sake";
        locations."/" = {
          proxyPass = "http://127.0.0.1:5001";
        };
      };
      "freshrss.sake" = {
        listen = [
          {
            addr = "127.0.0.1";
            port = 80;
          }
        ];
        serverName = "freshrss.sake";
        locations."/" = {
          proxyPass = "http://127.0.0.1:7755";
        };
      };
      "fullfeed.sake" = {
        listen = [
          {
            addr = "127.0.0.1";
            port = 80;
          }
        ];
        serverName = "fullfeed.sake";
        locations."/" = {
          proxyPass = "http://127.0.0.1:7756";
        };
      };
    };
    appendHttpConfig = ''
      server {
        listen 127.0.0.1:80;
        server_name localhost;
      }
    '';
  };

  networking.hosts = {
    "127.0.0.1" = ["dockge.sake" "freshrss.sake" "fullfeed.sake"];
  };
}
