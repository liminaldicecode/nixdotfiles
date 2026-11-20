{
  pkgs,
  krita-custom,
  ...
}:

{
  home.packages = with pkgs; [
    aseprite
    drawing
    freecad
    gimp
    godotPackages_4_7.godot
    godot_4_7-mono
    gpick
    inkscape
    kdePackages.kdenlive
    krita-custom
    libresprite
    mypaint
    pinta
    # END
  ];
}
