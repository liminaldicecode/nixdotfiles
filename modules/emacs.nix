{ pkgs, ... }:

{
  programs.emacs = {
    enable = true;
    package = pkgs.emacs-gtk;
    extraPackages =
      epkgs: with epkgs; [
        company
        vterm
        multiple-cursors
        nix-mode
        doom-themes
        xclip
        spaceline
        markdown-mode
        gdscript-mode
        lsp-mode
        hydra
        lsp-ui
        flycheck
        (treesit-grammars.with-grammars (
          grammars: with grammars; [
            tree-sitter-gdscript
          ]
        ))
      ];

  };
}
