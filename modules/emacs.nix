{ pkgs, ... }:

{
  programs.emacs = {
    enable = true;
    package = pkgs.emacs-gtk;
    extraPackages =
      epkgs: with epkgs; [
        undo-tree
        undo-fu
        goto-chg
        evil
        evil-numbers
        evil-collection
        evil-surround
        evil-commentary
        evil-multiedit
        adwaita-dark-theme
        company
        doom-modeline
        doom-themes
        flycheck
        gdscript-mode
        hydra
        lsp-mode
        lsp-ui
        markdown-mode
        multiple-cursors
        nix-mode
        vterm
        xclip
        (treesit-grammars.with-grammars (
          grammars: with grammars; [
            tree-sitter-gdscript
          ]
        ))
      ];

  };
}
