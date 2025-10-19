{ config, pkgs, ... }:

{
  programs.starship = {
    enable = true;
    settings = {
      add_newline = false;
      character.success_symbol = "➜";
    };
  };

  xdg.configFile."starship.toml".text = ''
    add_newline = false
    [character]
    success_symbol = "➜ "
    error_symbol = "✗ "
  '';
}
