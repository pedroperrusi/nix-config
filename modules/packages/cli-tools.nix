{ pkgs, ... }:

{
  home.packages = with pkgs; [
    bat
    btop
    curl
    eza
    fd
    fzf
    git
    lazygit
    mise
    ripgrep
    tree
    unzip
    wget
    zip
    zoxide
  ];
}
