{ ... }:

{
  programs.emacs = {
    enable = true;
    extraPackages =
      epkgs: with epkgs; [
        helix
        zen-mode
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
        rust-mode
        (treesit-grammars.with-grammars (
          grammars: with grammars; [
            tree-sitter-gdscript
          ]
        ))
      ];
    extraConfig = ''
              (ido-mode t)
              (add-hook 'after-init-hook 'global-company-mode)
              (menu-bar-mode 0)
              (electric-pair-mode t)
            '';
  };
}
