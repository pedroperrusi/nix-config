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

  # Symlink tmux config from dotfiles
  # Changes to ~/dotfiles/tmux/tmux.conf will require tmux reload (Ctrl+a R)
  # but NO Home Manager rebuild
  xdg.configFile."tmux/tmux.conf".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/tmux/tmux.conf";
}
