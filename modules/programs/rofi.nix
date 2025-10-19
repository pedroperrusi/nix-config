{ config, pkgs, lib, ... }:

{
  home.packages = [ pkgs.rofi ];

  home.file = {
    ".config/rofi/theme.rasi".source = ./rofi/theme.rasi;
    ".config/rofi/config.rasi".source = ./rofi/config.rasi;
  };

  # Automated keyboard shortcut setup for GNOME/Unity
  home.activation.rofiKeybinding = lib.hm.dag.entryAfter ["writeBoundary"] ''
    $DRY_RUN_CMD ${pkgs.writeShellScript "setup-rofi-keybinding" ''
      export GIO_EXTRA_MODULES=/usr/lib/x86_64-linux-gnu/gio/modules
      
      # Set custom keybindings list
      /usr/bin/gsettings set org.gnome.settings-daemon.plugins.media-keys custom-keybindings \
        "['/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/rofi/']" 2>/dev/null || true
      
      # Configure rofi keybinding
      /usr/bin/gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/rofi/ \
        name 'Rofi Application Launcher' 2>/dev/null || true
      
      /usr/bin/gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/rofi/ \
        command 'rofi -show drun' 2>/dev/null || true
      
      /usr/bin/gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/rofi/ \
        binding '<Super>r' 2>/dev/null || true
      
      echo "✓ Rofi keyboard shortcut (Super+R) configured"
    ''}
  '';
}
