{
  config,
  pkgs,
  lib,
  ...
}:

{

  home.username = "nix";
  home.homeDirectory = "/home/nix";

  imports = [
    ./modules/desktop.nix
    ./modules/design.nix
    ./modules/utils.nix
    ./modules/helix.nix
  ]
  ++ lib.optional (builtins.pathExists ./modules/git.nix) ./modules/git.nix;

  xfconf.enable = false;

  programs.bash = {
    enable = true;
    initExtra = ''
      bind "set completion-ignore-case on"
      			get() {
      				yt-dlp -t mp3 "$1"
                        }

      			getvid() {
      				yt-dlp -t mp4 "$1"
      			}
      		'';
    shellAliases = {
      k = "kak";
      code = "codium";
      cls = "clear";
      nix-maintain = "~/bin/nix-maintain";
      llm = "GGML_VK_VISIBLE_DEVICES=0 llama-server -m $HOME/models/gemma-4-E4B-it-Q4_K_M.gguf --device Vulkan0 --port 8081 -c 34816 -np 1 -ngl 99";
    };
  };

  dconf = {
    enable = true;
    settings."org/gnome/desktop/interface".color-scheme = "prefer-dark";
  };

  home.pointerCursor = {
    name = "Adwaita";
    package = pkgs.adwaita-icon-theme;
    size = 32;
    gtk.enable = true;
    x11.enable = true;
  };

  xdg.desktopEntries = {

    codium = {
      name = "VSCodium";
      exec = "codium %F";
      genericName = "Code Editor";
      comment = "Code Editing. Redefined.";
      terminal = false;
      icon = "/home/nix/.applications/VSCodium_new_dark_512x512.svg";
    };

    trackma-gtk = {
      name = "Trackma (GTK)";
      exec = "trackma-gtk %u";
      genericName = "Anime/Manga Tracker";
      comment = "Open source list manager for AniList and other trackers";
      terminal = false;
      icon = "/home/nix/.applications/trackma.svg";
      settings = {
        StartupWMClass = "trackma-gtk";
      };
    };
  };

  xdg.terminal-exec = {
    enable = true;
    settings = {
      default = [ "gnome-terminal" ];
    };
  };

  programs.vicinae = {
    enable = false;
  };

  home.stateVersion = "26.05";
}
