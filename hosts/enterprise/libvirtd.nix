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
    (writeShellScriptBin
      "bridge-up" ''
        sudo nmcli con add ifname br0 type bridge con-name br0
        sudo nmcli con add type bridge-slave ifname enp34s0 master br0
        sudo nmcli con modify br0 bridge.stp no
        sudo nmcli con down "Wired connection 1"
        sudo nmcli con up br0
        sudo virsh net-start br0
      '')
    (writeShellScriptBin
      "bridge-down" ''
        sudo nmcli con delete br0
        sudo nmcli con delete bridge-slave-enp34s0
        sudo nmcli con up "Wired connection 1"
        sudo virsh net-start default
      '')
  ];
}
