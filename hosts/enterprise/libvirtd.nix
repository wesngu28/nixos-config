{
  config,
  pkgs,
  ...
}: {
  programs.dconf.enable = true;

  home-manager.users."serpe" = {
    dconf = {
      enable = true;
      settings = {
        "org/virt-manager/virt-manager/connections" = {
          autoconnect = ["qemu:///system"];
          uris = ["qemu:///system"];
        };
      };
    };
  };
  virtualisation = {
    libvirtd = {
      enable = true;
      qemu = {
        swtpm.enable = true;
        ovmf.enable = true;
        ovmf.packages = [pkgs.OVMFFull.fd];
      };
    };
    spiceUSBRedirection.enable = true;
  };
  services.spice-vdagentd.enable = true;
  programs.virt-manager.enable = true;
  users.users.serpe.extraGroups = ["libvirtd"];
  networking.firewall.checkReversePath = false;
  environment.systemPackages = with pkgs; [
    #   virt-manager
    virt-viewer
    spice
    spice-gtk
    spice-protocol
    #   win-virtio
    #   win-spice
    gnome.adwaita-icon-theme
  ];
}
