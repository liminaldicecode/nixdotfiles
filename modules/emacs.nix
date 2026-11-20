{ pkgs, ... }:

{
  programs.emacs = {
    enable = true;
    package = pkgs.emacs-gtk;
    extraPackages =
      epkgs: with epkgs; [
        company
        magit
        eglot
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
