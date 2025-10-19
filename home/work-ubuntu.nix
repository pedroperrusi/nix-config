{ config, pkgs, lib, modulesPath, ... }:

{
  imports = [
    # Shell configuration
    (modulesPath + /shell/zsh.nix)
    (modulesPath + /shell/starship.nix)
    (modulesPath + /shell/direnv.nix)
    
    # Programs
    (modulesPath + /programs/git.nix)
    (modulesPath + /programs/neovim.nix)
    (modulesPath + /programs/tmux.nix)
    (modulesPath + /programs/alacritty.nix)
    
    # Packages
    (modulesPath + /packages/cli-tools.nix)
    (modulesPath + /packages/tui-tools.nix)
    (modulesPath + /packages/utilities.nix)
    (modulesPath + /packages/fonts.nix)
  ];

  home.username = "perrusi";
  home.homeDirectory = "/home/perrusi";
  home.stateVersion = "24.05";

  home.sessionVariables = {
    EDITOR = "nvim";
    PAGER = "bat";
  };

  programs.home-manager.enable = true;
}
