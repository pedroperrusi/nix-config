{ pkgs, ... }:

{
  home.packages = with pkgs; [
    fzf
    zoxide
    ripgrep
    eza
    fd
  ];
}
