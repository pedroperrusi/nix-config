{ pkgs, ... }:

{
  home.packages = with pkgs; [
    bat
    jq
    tree
    delta
    tealdeer
  ];
}
