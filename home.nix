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
  ]
  ++ lib.optional (builtins.pathExists ./modules/git.nix) ./modules/git.nix;

  programs.ghostty = {
    enable = true;
    systemd.enable = true;
    enableBashIntegration = true;
    settings = {
      gtk-single-instance = true;
      font-family = "CaskaydiaCove Nerd Font Mono";
      font-size = "16";
      theme = "Adwaita Dark";
      window-padding-x = "10";
      window-padding-y = "10";
    };
  };

  programs.vim = {
    enable = true;
    plugins = with pkgs.vimPlugins; [
      vim-airline
    ];
  };

  programs.emacs = {
    enable = true;
    extraPackages = epkgs: [
      epkgs.company
      epkgs.vterm
      epkgs.multiple-cursors
      epkgs.nix-mode
      epkgs.doom-themes
      epkgs.xclip
      epkgs.evil
      epkgs.spaceline
      epkgs.evil-commentary
      epkgs.undo-fu
      epkgs.goto-chg
      epkgs.evil-collection
      epkgs.vertico
    ];
    extraConfig = ''
      (ido-mode t)
      (add-hook 'after-init-hook 'global-company-mode)
      (menu-bar-mode 0)
      (electric-pair-mode t)
    '';
  };

  xfconf.enable = false;

  programs.bash = {
    enable = true;
    initExtra = ''bind "set completion-ignore-case on"'';
    shellAliases = {
      v = "vim";
      code = "codium";
      em = "emacs -nw";
      cls = "clear";
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
  };

  xdg.desktopEntries = {
    obsidian = {
      name = "Obsidian";
      exec = "obsidian %u";
      genericName = "Note Taking";
      terminal = false;
      icon = "/home/nix/.applications/Obsidian.svg";
    };
  };

  programs.vicinae = {
    enable = true;
  };

  home.stateVersion = "26.05";
}
