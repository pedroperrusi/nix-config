{ config, pkgs, lib, ... }:

let
  # Short-hand for vim plugins
  v = pkgs.vimPlugins;

in {
  # --- Who/where ---
  home.username = "perrusi";
  home.homeDirectory = "/home/perrusi";
  # Track HM format; bump only when HM asks you to in a migration note
  home.stateVersion = "24.05";

  # --- Packages you want installed (user scope; no sudo) ---
  home.packages = with pkgs; [
    # Omarchy-style shell tools
    fzf zoxide ripgrep eza fd
    # TUI git (neovim is configured via programs.neovim below)
    lazygit
    # Useful companions
    bat jq tree htop btop delta tealdeer
  ];

  # --- Shell / prompt / environment ---
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    
    # Make zsh the default shell
    defaultKeymap = "emacs";
    
    # Set login shell path
    loginExtra = ''
      # Source Home Manager session variables
      [ -f ~/.nix-profile/etc/profile.d/hm-session-vars.sh ] && source ~/.nix-profile/etc/profile.d/hm-session-vars.sh
    '';

    # Aliases & functions live here (no separate dotfile needed)
    shellAliases = {
      ls  = "eza -lh --group-directories-first --icons=auto";
      lsa = "ls -a";
      lt  = "eza --tree --level=2 --long --icons --git";
      lta = "lt -a";
      n   = "nvim";
      # quick fuzzy-find with preview pane
      ff  = ''fzf --preview 'bat --style=numbers --color=always {}' '';
      # git shortcuts
      g   = "git";
      lg  = "lazygit";
      # home-manager shortcut
      hm  = "home-manager switch --flake ~/nix-config#pedro@work-ubuntu";
    };

    initExtra = ''
      # zoxide / fzf hooks
      eval "$(${pkgs.zoxide}/bin/zoxide init zsh)"
      # if you want fzf keybindings:
      source ${pkgs.fzf}/share/fzf/key-bindings.zsh
      source ${pkgs.fzf}/share/fzf/completion.zsh
    '';
  };

  programs.starship = {
    enable = true;
    settings = {
      add_newline = false;
      character.success_symbol = "➜";
    };
  };

  programs.fzf.enable = true;
  programs.eza = {
    enable = true;
    enableZshIntegration = false; # we set our own aliases above
  };

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  programs.zoxide.enable = true;

  # --- Git managed fully in Nix (no separate ~/.gitconfig) ---
  programs.git = {
    enable = true;
    userName = "Pedro Perrusi";
    userEmail = "pedro.perrusi@bbraun.com";
    extraConfig = {
      core.editor = "nvim";
      init.defaultBranch = "main";
      pull.rebase = true;
      push.default = "current";
      diff.tool = "delta";
      interactive.diffFilter = "delta --color-only";
      delta = {
        navigate = true;
        line-numbers = true;
      };
    };
  };

  # --- Neovim managed in Nix (plugins + minimal Lua config) ---
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;

    # Install plugins from nixpkgs’ vimPlugins
    plugins = with v; [
      lazy-nvim                 # plugin manager
      telescope-nvim            # fuzzy finder UI
      plenary-nvim              # telescope dependency
      gitsigns-nvim
      lualine-nvim
      nvim-web-devicons
      comment-nvim
      which-key-nvim
      nvim-treesitter
      catppuccin-nvim
      # Optional: LazyGit floating terminal helper
      lazygit-nvim
    ];

    # Minimal Lua to wire things (leader, telescope, lualine, etc.)
    extraLuaConfig = ''
      -- Leader like Omarchy/LazyVim style
      vim.g.mapleader = ' '

      -- Colorscheme
      vim.cmd.colorscheme "catppuccin"

      -- Telescope quick maps
      local telescope = require('telescope.builtin')
      vim.keymap.set('n', '<leader><leader>', telescope.find_files, { desc = 'Find files' })
      vim.keymap.set('n', '<leader>sg', telescope.live_grep, { desc = 'Live grep' })

      -- File tree suggestion: use telescope + oil.nvim (optional)
      -- vim.keymap.set('n', '<leader>e', require('oil').open_float, { desc = 'File explorer' })

      -- LazyGit in a floating window (similar to Space GG in Omarchy)
      vim.keymap.set('n', '<leader>gg', function()
        vim.cmd('LazyGit')
      end, { desc = 'LazyGit' })

      -- Gitsigns
      require('gitsigns').setup()

      -- Lualine
      require('lualine').setup { options = { theme = 'auto' } }

      -- Which-key helper for leader menus
      require('which-key').setup()

      -- Treesitter (basic)
      require('nvim-treesitter.configs').setup {
        highlight = { enable = true },
        indent = { enable = true }
      }
    '';
  };

  # --- Files written directly by Nix (examples) ---
  # If you prefer *all* config inside Nix, use home.file/xdg.configFile.
  # Here’s a Starship example; Git & Neovim we configured via modules above.
  xdg.configFile."starship.toml".text = ''
    add_newline = false
    [character]
    success_symbol = "➜ "
    error_symbol = "✗ "
  '';

  # --- Environment defaults ---
  home.sessionVariables = {
    EDITOR = "nvim";
    PAGER = "bat";
  };

  # --- Services (optional) ---
  # services.gpg-agent.enable = true;

  # --- Let Home Manager manage itself ---
  programs.home-manager.enable = true;
}