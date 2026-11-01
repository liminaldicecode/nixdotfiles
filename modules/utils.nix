{ pkgs, ... }:

{
  home.packages = with pkgs; [
    age
    appimage-run
    aria2
    codex
    exiftool
    fastfetch
    flashrom
    gcc
    htop
    keyd
    killall
    nil
    nixpkgs-fmt
    nodejs
    p7zip
    ripgrep
    st
    steam-run
    timer
    unbound
    pfetch
    btop
    unrar
    scrcpy
    adbtuifm
    gdtoolkit_4
    lua
    netcat
    marksman
    wezterm
    imagemagick
    disfetch
    lldb
    gdb
    adwaita-icon-theme
    ripgrep
    # END
  ];
}
