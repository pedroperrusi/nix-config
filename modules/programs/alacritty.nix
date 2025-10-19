{ config, pkgs, ... }:

{
  programs.alacritty = {
    enable = true;
    
    settings = {
      env = {
        TERM = "xterm-256color";
      };

      window = {
        opacity = 0.95;
        padding = {
          x = 8;
          y = 8;
        };
        decorations = "full";
        dynamic_title = true;
      };

      scrolling = {
        history = 10000;
        multiplier = 3;
      };

      font = {
        normal = {
          family = "JetBrainsMono Nerd Font";
          style = "Regular";
        };
        bold = {
          family = "JetBrainsMono Nerd Font";
          style = "Bold";
        };
        italic = {
          family = "JetBrainsMono Nerd Font";
          style = "Italic";
        };
        bold_italic = {
          family = "JetBrainsMono Nerd Font";
          style = "Bold Italic";
        };
        size = 12.0;
      };

      # Catppuccin Mocha theme
      colors = {
        primary = {
          background = "#1e1e2e";
          foreground = "#cdd6f4";
          dim_foreground = "#7f849c";
          bright_foreground = "#cdd6f4";
        };
        
        cursor = {
          text = "#1e1e2e";
          cursor = "#f5e0dc";
        };
        
        vi_mode_cursor = {
          text = "#1e1e2e";
          cursor = "#b4befe";
        };
        
        search = {
          matches = {
            foreground = "#1e1e2e";
            background = "#a6adc8";
          };
          focused_match = {
            foreground = "#1e1e2e";
            background = "#a6e3a1";
          };
        };
        
        hints = {
          start = {
            foreground = "#1e1e2e";
            background = "#f9e2af";
          };
          end = {
            foreground = "#1e1e2e";
            background = "#a6adc8";
          };
        };
        
        selection = {
          text = "#1e1e2e";
          background = "#f5e0dc";
        };
        
        normal = {
          black = "#45475a";
          red = "#f38ba8";
          green = "#a6e3a1";
          yellow = "#f9e2af";
          blue = "#89b4fa";
          magenta = "#f5c2e7";
          cyan = "#94e2d5";
          white = "#bac2de";
        };
        
        bright = {
          black = "#585b70";
          red = "#f38ba8";
          green = "#a6e3a1";
          yellow = "#f9e2af";
          blue = "#89b4fa";
          magenta = "#f5c2e7";
          cyan = "#94e2d5";
          white = "#a6adc8";
        };
        
        dim = {
          black = "#45475a";
          red = "#f38ba8";
          green = "#a6e3a1";
          yellow = "#f9e2af";
          blue = "#89b4fa";
          magenta = "#f5c2e7";
          cyan = "#94e2d5";
          white = "#bac2de";
        };
      };

      cursor = {
        style = {
          shape = "Block";
          blinking = "On";
        };
        blink_interval = 750;
        unfocused_hollow = true;
      };

      mouse = {
        hide_when_typing = true;
      };

      selection = {
        save_to_clipboard = true;
      };

      shell = {
        program = "${pkgs.zsh}/bin/zsh";
      };

      keyboard = {
        bindings = [
          { key = "V"; mods = "Control|Shift"; action = "Paste"; }
          { key = "C"; mods = "Control|Shift"; action = "Copy"; }
          { key = "Plus"; mods = "Control"; action = "IncreaseFontSize"; }
          { key = "Minus"; mods = "Control"; action = "DecreaseFontSize"; }
          { key = "Key0"; mods = "Control"; action = "ResetFontSize"; }
        ];
      };
    };
  };
}
