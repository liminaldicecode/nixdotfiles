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
    ./modules/nvim.nix

  ]
  ++ lib.optional (builtins.pathExists ./modules/git.nix) ./modules/git.nix;

  programs.ghostty = {
    enable = true;
    systemd.enable = true;
    enableBashIntegration = true;
    settings = {
      gtk-single-instance = true;
      font-family = "CaskaydiaCove NF";
      font-size = "16.5";
      theme = "Dark Modern";
      window-padding-x = "5";
      window-padding-y = "5";
    };
  };

  programs.tmux = {
    enable = true;
  };

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
      v = "nvim";
      code = "codium";
      em = "emacs -nw";
      cls = "clear";
      nix-maintain = "~/bin/nix-maintain";
      llm = "GGML_VK_VISIBLE_DEVICES=0 llama-server -m $HOME/models/gemma-4-E4B-it-Q4_K_M.gguf --device Vulkan0 --port 8081 -c 2048 -np 1 -ngl 99";
    };
  };

  dconf = {
    enable = true;
    settings."org/gnome/desktop/interface".color-scheme = "prefer-dark";
  };

  # home.pointerCursor = {
  #   name = "Adwaita";
  #   package = pkgs.adwaita-icon-theme;
  #   size = 32;
  #   gtk.enable = true;
  # };

  home.pointerCursor = {
    name = "breeze_cursors";
    package = pkgs.kdePackages.breeze;
    size = 32;
    gtk.enable = true;
    x11.enable = true;
  };

  xdg.desktopEntries = {
    obsidian = {
      name = "Obsidian";
      exec = "obsidian %u";
      genericName = "Note Taking";
      comment = "The free and flexible app for your private thoughts.";
      terminal = false;
      icon = "/home/nix/.applications/Obsidian.svg";
      settings = {
        StartupWMClass = "obsidian";
      };
    };

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

  programs.vicinae = {
    enable = true;
  };

  home.stateVersion = "26.05";
}
