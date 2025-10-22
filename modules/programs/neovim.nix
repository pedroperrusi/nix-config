{ config, pkgs, pkgs-unstable, ... }:

{
  programs.neovim = {
    enable = true;
    package = pkgs-unstable.neovim-unwrapped;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;

    extraPackages = with pkgs-unstable; [
      # LSP and formatting for Lua/Neovim config
      lua-language-server
      stylua
    ];
  };

  # Symlink to external Neovim config in ~/dotfiles
  # This allows managing plugins with lazy.nvim without rebuilding Home Manager
  xdg.configFile."nvim" = {
    source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/nvim";
    recursive = true;
  };
}
