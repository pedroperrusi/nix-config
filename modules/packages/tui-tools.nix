{ pkgs, ... }:

{
  home.packages = with pkgs; [
    lazygit
    htop
    btop
  ];
}
