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
    tldr
    tor
    unbound
    vis
    xev
    opencode
    pfetch
    btop
    unrar
    manim
    scrcpy
    adbtuifm
    gdtoolkit_4
    librespot
    lua
    netcat
    spotdl
    marksman
    cargo
    rust-analyzer
    wezterm
    imagemagick
    # END
  ];
}
