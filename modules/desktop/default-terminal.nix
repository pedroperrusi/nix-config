{ pkgs, pkgs-unstable, ... }:

{
  # Create a desktop entry for ghostty-gl
  xdg.desktopEntries.ghostty = {
    name = "Ghostty";
    genericName = "Terminal Emulator";
    comment = "Fast, feature-rich terminal emulator";
    exec = "ghostty-gl";
    icon = "utilities-terminal";
    terminal = false;
    categories = [ "System" "TerminalEmulator" ];
    settings = {
      Keywords = "shell;prompt;command;commandline;cmd;";
      StartupNotify = "true";
      X-GNOME-UsesNotifications = "true";
    };
  };

  # Set ghostty-gl as the default terminal emulator
  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "x-scheme-handler/terminal" = "ghostty.desktop";
    };
  };

  # Create a symlink for x-terminal-emulator alternative
  home.file.".local/bin/x-terminal-emulator" = {
    source = pkgs.writeShellScript "x-terminal-emulator" ''
      exec ghostty-gl "$@"
    '';
    executable = true;
  };
}
