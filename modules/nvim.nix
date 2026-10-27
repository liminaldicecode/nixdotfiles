{
  inputs,
  pkgs,
  neovim-nightly-overlay,
  ...
}:

{

  programs.neovim = {
    enable = true;

    plugins = with pkgs.vimPlugins; [
      nvim-tree-lua
      vim-nix
      nvim-treesitter.withAllGrammars
    ];

    initLua = ''
      colorscheme=habamax
      vim.opt.number = true
      vim.opt.relativenumber = true
      vim.o.cursorline = true
      vim.o.inccommand = 'split'
    '';
  };

}
