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
    
    extraConfig = ''
      # Easy config reload
      bind r source-file ~/.config/tmux/tmux.conf \; display "Reloaded!"

      # Better splitting with current path
      bind | split-window -h -c "#{pane_current_path}"
      bind - split-window -v -c "#{pane_current_path}"
      unbind '"'
      unbind %

      # Vim-style pane navigation
      bind h select-pane -L
      bind j select-pane -D
      bind k select-pane -U
      bind l select-pane -R

      # Vim-style pane resizing
      bind -r H resize-pane -L 5
      bind -r J resize-pane -D 5
      bind -r K resize-pane -U 5
      bind -r L resize-pane -R 5

      # Enable true colors
      set-option -sa terminal-overrides ",xterm*:Tc"

      # Window renumbering
      set-option -g renumber-windows on

      # Status bar styling
      set -g status-position top
      set -g status-style 'bg=#1e1e2e fg=#cdd6f4'
      set -g status-left '#[fg=#89b4fa,bold] #S '
      set -g status-right '#[fg=#a6e3a1]%Y-%m-%d #[fg=#89dceb]%H:%M'
      
      # Window status styling
      set -g window-status-current-style 'fg=#89b4fa,bold'
      set -g window-status-style 'fg=#6c7086'

      # Pane border styling
      set -g pane-border-style 'fg=#313244'
      set -g pane-active-border-style 'fg=#89b4fa'

      # Activity monitoring
      setw -g monitor-activity on
      set -g visual-activity off
    '';

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
