{ pkgs, pkgs-unstable, ... }:

{
  home.packages = with pkgs-unstable; [
    nodejs_22

    # Additional package managers (npm comes with nodejs_22)
    nodePackages.pnpm
    nodePackages.yarn

    # Useful for Neovim Mason and other tools
    luajitPackages.luarocks-nix
  ];
}
