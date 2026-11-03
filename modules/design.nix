{
  pkgs,
  krita-custom,
  ...
}:

{
  home.packages = with pkgs; [
    mypaint
    drawing
    aseprite
    freecad
    gimp
    godotPackages_4_7.godot
    gpick
    inkscape
    kdePackages.kdenlive
    krita-custom
    libresprite
    pinta
    # END
  ];
}
