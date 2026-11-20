{ pkgs, ... }:

{
  programs.emacs = {
    enable = true;
    package = pkgs.emacs-gtk;
    extraPackages =
      epkgs: with epkgs; [
        company
        doom-modeline
        eglot
        flycheck
        gdscript-mode
        hydra
        lsp-mode
        lsp-ui
        magit
        markdown-mode
        meow
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
