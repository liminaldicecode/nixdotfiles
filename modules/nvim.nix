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
    extraConfig = ''
      set number
      set relativenumber
      set expandtab
      set shiftwidth=2
      set tabstop=2
    '';

    initLua = ''
      vim.lsp.config('gdscript', {})
      vim.lsp.enable('gdscript')
      vim.o.complete = ".,w,b,o"
      vim.o.completeopt = "menuone,noselect,fuzzy"
      vim.o.autocomplete = true
      vim.o.autocompletedelay = 250

      vim.g.airline_theme = 'deus'

      require("neomodern").setup({
      bg = "default",
      theme = "roseprime",
      gutter = {
        cursorline = false,
        dark = false,
      },
      diagnostics = {
        darker = true,
        undercurl = true,
        background = true,
      },
      })

      require("neomodern").load()

      vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("user_lsp_completion", { clear = true }),
      callback = function(args)
      local client = vim.lsp.get_client_by_id(args.data.client_id)
      if client and client:supports_method("textDocument/completion") then vim.lsp.completion.enable(true, client.id, args.buf, {
      autotrigger = true,
      })
      end
      end,
      })
    '';

    plugins = with pkgs.vimPlugins; [
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
