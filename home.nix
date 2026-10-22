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
      theme = "Dark Modern";
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
    extraPackages = epkgs: with epkgs; [
      company
      vterm
      multiple-cursors
      nix-mode
      doom-themes
      xclip
      evil
      spaceline
      evil-commentary
      undo-fu
      goto-chg
      evil-collection
      vertico
      markdown-mode
      gdscript-mode
      evil-numbers
      lsp-mode
      hydra
      lsp-ui
      flycheck
      (treesit-grammars.with-grammars (grammars: with grammars; [
        tree-sitter-gdscript
      ]))
      # EMACS
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
  };

  programs.vicinae = {
    enable = true;
  };

  home.stateVersion = "26.05";
}
