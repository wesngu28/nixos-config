{pkgs, ...}: let
  waydroid-session = pkgs.writeShellScriptBin "waydroid-session" ''
    kwriteconfig6 --file kglobalshortcutsrc --group "spectacle.desktop" --key "RectangularRegionScreenShot" "Meta+S,Shift+Print,Capture Rectangular Region"
        kglobalacceld &
        spectacle --background &
        kwin_wayland --xwayland -- waydroid show-full-ui
  '';
in {
  environment.systemPackages = with pkgs; [
    kdePackages.kwin
    kdePackages.kscreenlocker
    kdePackages.konsole
    kdePackages.spectacle
    kdePackages.kglobalacceld
    waydroid-session
  ];
  security.pam.services.kde = {};
}
