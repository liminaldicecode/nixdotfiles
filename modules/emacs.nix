{ pkgs, ... }:

{
  programs.emacs = {
    enable = true;
    package = pkgs.emacs-gtk;
    extraPackages =
      epkgs: with epkgs; [
        company
        doom-modeline
        good-scroll
        eglot
        flycheck
        gdscript-mode
        gdshader-mode
        hydra
        lsp-mode
        lsp-ui
        magit
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
