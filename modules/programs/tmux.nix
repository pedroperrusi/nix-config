{ config, pkgs, ... }:

{
  programs.tmux = {
    enable = true;
    terminal = "screen-256color";
    historyLimit = 10000;
    keyMode = "vi";
    mouse = true;

    baseIndex = 1;
    escapeTime = 0;

    prefix = "C-a";

    extraConfig = builtins.readFile ./tmux/tmux.conf;

    plugins = with pkgs.tmuxPlugins; [
      sensible
      yank
      {
        plugin = catppuccin;
        extraConfig = ''
          set -g @catppuccin_flavour 'mocha'
          set -g @catppuccin_window_tabs_enabled on
        '';
      }
    ];
  };
}
