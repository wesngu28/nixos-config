{pkgs ? import <nixpkgs> {}}:
pkgs.mkShell
{
  nativeBuildInputs = with pkgs; [
    python3
    python311Packages.pip
  ];

  shellHook = ''
    VENV=.venv
    if test ! -d $VENV; then
      python -m venv $VENV
    fi
    source ./$VENV/bin/activate
  '';
}
