{pkgs}: let
  imgLink = "https://w.wallhaven.cc/full/28/wallhaven-28w23y.jpg";
  image = pkgs.fetchurl {
    url = imgLink;
    sha256 = "sha256-lAUB2lFmWXd3PYobWpTvW3Y6qf18DQLz5WYZbiVUB/4=";
  };
  themeConfig = builtins.toFile "theme.conf" ''
    [General]
    Background="Background.jpg"
    DimBackgroundImage="0.0"
    ScaleImageCropped="true"
    ScreenWidth="3440"
    ScreenHeight="1440"
    FullBlur="false"
    PartialBlur="true"
    BlurRadius="50"
    HaveFormBackground="true"
    FormPosition="left"
    BackgroundImageHAlignment="center"
    BackgroundImageVAlignment="center"
    MainColor="#cdd6f4"
    AccentColor="#b4befe"
    BackgroundColor="#11111b"
    OverrideLoginButtonTextColor=""
    InterfaceShadowSize="6"
    InterfaceShadowOpacity="0.6"
    RoundCorners="15"
    ScreenPadding="0"
    Font="Noto Sans"
    FontSize=""
    ForceRightToLeft="false"
    ForceLastUser="true"
    ForcePasswordFocus="true"
    ForceHideCompletePassword="true"
    ForceHideSystemButtons="false"
    AllowEmptyPassword="false"
    AllowBadUsernames="false"
    HeaderText="Welcome"
  '';
in
  pkgs.stdenv.mkDerivation {
    name = "sddm-theme";
    src = pkgs.fetchFromGitHub {
      owner = "MarianArlt";
      repo = "sddm-sugar-dark";
      rev = "ceb2c455663429be03ba62d9f898c571650ef7fe";
      sha256 = "0153z1kylbhc9d12nxy9vpn0spxgrhgy36wy37pk6ysq7akaqlvy";
    };
    installPhase = ''
      mkdir -p $out
      cp -R ./* $out/
      cd $out/
      rm Background.jpg
      cp -r ${image} $out/Background.jpg
      rm theme.conf
      cp ${themeConfig} $out/theme.conf
    '';
  }
