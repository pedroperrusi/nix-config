{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # Nerd Fonts with icons and symbols
    (nerdfonts.override { fonts = [ "JetBrainsMono" "NerdFontsSymbolsOnly" ]; })
  ];
}
