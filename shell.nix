{
  pkgs ? import <nixpkgs> { },
}:

pkgs.mkShell {
  name = "dev-environment";
  buildInputs = [
    pkgs.nodejs
  ];
  shellHook = ''
  echo "start developing..."
  '';
}
