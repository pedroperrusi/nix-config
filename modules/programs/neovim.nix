{ config, pkgs, ... }:

let
  v = pkgs.vimPlugins;
in {
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;

    plugins = with v; [
      lazy-nvim
      telescope-nvim
      plenary-nvim
      gitsigns-nvim
      lualine-nvim
      nvim-web-devicons
      comment-nvim
      which-key-nvim
      nvim-treesitter
      catppuccin-nvim
      lazygit-nvim
    ];

    extraLuaConfig = ''
      vim.g.mapleader = ' '

      vim.cmd.colorscheme "catppuccin"

      local telescope = require('telescope.builtin')
      vim.keymap.set('n', '<leader><leader>', telescope.find_files, { desc = 'Find files' })
      vim.keymap.set('n', '<leader>sg', telescope.live_grep, { desc = 'Live grep' })

      vim.keymap.set('n', '<leader>gg', function()
        vim.cmd('LazyGit')
      end, { desc = 'LazyGit' })

      require('gitsigns').setup()
      require('lualine').setup { options = { theme = 'auto' } }
      require('which-key').setup()

      require('nvim-treesitter.configs').setup {
        highlight = { enable = true },
        indent = { enable = true }
      }
    '';
  };
}
