{
  pkgs,
  krita-custom,
  ...
}:

{
  home.packages = with pkgs; [
    aseprite
    calligraphy
    drawpile
    freecad
    gimp
    godotPackages_4_7.godot
    gpick
    inkscape
    kdePackages.kdenlive
    krita-custom
    libresprite
    lorien
    pencil2d
    pinta
    # END
  ];
}
