{
  inputs,
  pkgs,
  neovim-nightly-overlay,
  ...
}:

{

  programs.neovim = {
    enable = true;
    defaultEditor = true;

    initLua = ''${builtins.readFile ./init.lua}'';

    plugins = with pkgs.vimPlugins; [
      conform-nvim
      markdown-nvim
      telescope-nvim
      vim-airline
      vim-airline-themes
      nvim-lspconfig
      neomodern-nvim
      nvim-cmp
      cmp-nvim-lsp
      luasnip
      cmp_luasnip
      nvim-tree-lua
      vim-nix
      nvim-treesitter.withAllGrammars
      {
        plugin = mini-nvim;
        type = "lua";
        config = ''
          require('mini.ai').setup({})
          require('mini.surround').setup({})
          require('mini.pairs').setup({})
          require('mini.comment').setup({})
        '';
      }
    ];

  };

}
