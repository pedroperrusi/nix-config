{ config, pkgs, pkgs-unstable, ... }:

let
  # Simple wrapper without nixGL package dependency
  ghostty-wrapper = pkgs.writeShellScriptBin "ghostty-gl" ''
    # Try to use nixGL if available on the system
    if command -v nixGL &> /dev/null; then
      exec nixGL ${pkgs-unstable.ghostty}/bin/ghostty "$@"
    else
      # Fallback: try with system OpenGL libraries
      export LD_LIBRARY_PATH=/usr/lib/x86_64-linux-gnu:$LD_LIBRARY_PATH
      exec ${pkgs-unstable.ghostty}/bin/ghostty "$@"
    fi
  '';
in
{
  # Install Ghostty from unstable
  home.packages = [
    pkgs-unstable.ghostty
    ghostty-wrapper
  ];

  xdg.configFile."ghostty/config".text = ''
    # Font configuration
    font-family = JetBrainsMono Nerd Font
    font-size = 12
    font-feature = -calt

    # Window appearance
    window-padding-x = 8
    window-padding-y = 8
    background-opacity = 0.95

    # Theme - Catppuccin Mocha
    background = 1e1e2e
    foreground = cdd6f4
    cursor-color = f5e0dc
    selection-background = f5e0dc
    selection-foreground = 1e1e2e

    # Regular colors
    palette = 0=#45475a
    palette = 1=#f38ba8
    palette = 2=#a6e3a1
    palette = 3=#f9e2af
    palette = 4=#89b4fa
    palette = 5=#f5c2e7
    palette = 6=#94e2d5
    palette = 7=#bac2de

    # Bright colors
    palette = 8=#585b70
    palette = 9=#f38ba8
    palette = 10=#a6e3a1
    palette = 11=#f9e2af
    palette = 12=#89b4fa
    palette = 13=#f5c2e7
    palette = 14=#94e2d5
    palette = 15=#a6adc8

    # Cursor
    cursor-style = block
    cursor-style-blink = true

    # Shell
    command = ${pkgs.zsh}/bin/zsh

    # Scrollback
    scrollback-limit = 10000

    # Mouse
    copy-on-select = true
    mouse-hide-while-typing = true

    # Keybindings
    keybind = ctrl+shift+c=copy_to_clipboard
    keybind = ctrl+shift+v=paste_from_clipboard
    keybind = ctrl+plus=increase_font_size:1
    keybind = ctrl+minus=decrease_font_size:1
    keybind = ctrl+0=reset_font_size

    # Tabs
    keybind = ctrl+shift+t=new_tab
    keybind = ctrl+shift+w=close_surface
    keybind = ctrl+tab=next_tab
    keybind = ctrl+shift+tab=previous_tab

    # Performance
    unfocused-split-opacity = 0.8
  '';
}
