{ pkgs, ... }:

{
  home.packages = with pkgs; [
    fzf
    zoxide
    ripgrep
    eza
    fd
    fastfetch
    gh
    gh-copilot
  ];
}
