{ pkgs, pkgs-unstable, ... }:

{
  home.packages = with pkgs-unstable; [
    nodejs_22

    # Package managers
    nodePackages.npm
    nodePackages.pnpm
    nodePackages.yarn

    # Useful for Neovim Mason and other tools
    luajitPackages.luarocks-nix
  ];
}
