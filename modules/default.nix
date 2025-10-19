{ config, pkgs, lib, ... }:

{
  imports = [
    # Shell
    ./shell/zsh.nix
    ./shell/starship.nix
    ./shell/direnv.nix
    
    # Programs
    ./programs/git.nix
    ./programs/neovim.nix
    
    # Packages
    ./packages/cli-tools.nix
    ./packages/tui-tools.nix
    ./packages/utilities.nix
  ];
}
