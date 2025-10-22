{ config, pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
  };

  # Symlink to external Neovim config in ~/dotfiles
  # This allows managing plugins with lazy.nvim without rebuilding Home Manager
  xdg.configFile."nvim" = {
    source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/nvim";
    recursive = true;
  };
}
