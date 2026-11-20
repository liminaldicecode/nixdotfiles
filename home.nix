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
    ./modules/emacs.nix
    ./modules/helix.nix
  ]
  ++ lib.optional (builtins.pathExists ./modules/git.nix) ./modules/git.nix;

  xfconf.enable = false;

  programs.bash = {
    enable = true;
    initExtra = ''
      bind "set completion-ignore-case on"
      			get() {
      				yt-dlp -S ext:m4a -x --embed-thumbnail "$1"
                        }
      			getvid() {
      				yt-dlp -t mp4 "$1"
      			}
      			gettrim() {
      				yt-dlp -o "%(title).100B [%(id).50B].%(ext)s" -t mp3 "$1"
      			}
      		'';

    shellAliases = {
      em = "emacs -nw";
      v = "vis";
      n = "nnn";
      k = "kak";
      code = "codium";
      cls = "clear";
      nix-maintain = "~/bin/nix-maintain";
      llm = "GGML_VK_VISIBLE_DEVICES=0 llama-server -m $HOME/models/gemma-4-E4B-it-Q4_K_M.gguf --device Vulkan0 --port 8081 -c 34816 -np 1 -ngl 99";
    };
  };

  
  gtk = {
    enable = true;
    colorScheme = "light";
    theme = {
      name = "adw-gtk3";
      package = pkgs.adw-gtk3;
    };
  };

  dconf = {
    settings = {
      "org/gnome/desktop/interface" = {
        color-scheme = "prefer-light";
      };
    };
  };
  
  home.pointerCursor = {
    name = "Adwaita";
    package = pkgs.adwaita-icon-theme;
    size = 36;
    gtk.enable = true;
    x11.enable = true;
  };

  xdg.desktopEntries = {

    "godot4.7" = {
      name = "Godot AMD";
      exec = ''env VK_LOADER_DRIVERS_SELECT="*radeon*" godot4.7 %f'';
      genericName = "Game Engine";
      comment = "Launch Godot forced on AMD iGPU";
      terminal = false;
      icon = "godot";
    };

    "godot4.7-mono" = {
      name = "Godot Mono";
      exec = ''env VK_LOADER_DRIVERS_SELECT="*radeon*" godot4.7-mono%f'';
      genericName = "Game Engine";
      comment = "Launch Godot forced on AMD iGPU";
      terminal = false;
      icon = "godot";
    };

    iotas = {
      name = "Iotas";
      exec = "iotas";
      genericName = "Note Taking App";
      comment = "Iotas aims to provide distraction-free note taking via its mobile-first design.";
      terminal = false;
      icon = "/home/nix/.applications/iotas.svg";
      noDisplay = false;
    };

    codium = {
      name = "VSCodium";
      exec = "codium %F";
      genericName = "Code Editor";
      comment = "Code Editing. Redefined.";
      terminal = false;
      # icon = "/home/nix/.applications/VSCodium_new_dark_512x512.svg";
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
