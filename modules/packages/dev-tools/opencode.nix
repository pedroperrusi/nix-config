{ pkgs, config, ... }:

let
  opencode-installer = pkgs.writeShellScriptBin "opencode" ''
    set -euo pipefail

    INSTALL_DIR="$HOME/.opencode/bin"
    OPENCODE_BIN="$INSTALL_DIR/opencode"

    if [ ! -f "$OPENCODE_BIN" ]; then
      echo "OpenCode not found. Installing..."
      export VERSION=""
      ${pkgs.curl}/bin/curl -fsSL https://raw.githubusercontent.com/sst/opencode/refs/heads/dev/install | ${pkgs.bash}/bin/bash
      echo "Installation complete!"
    fi

    exec "$OPENCODE_BIN" "$@"
  '';

  githubCopilotHost = "bbraun.ghe.com";
in
{
  config = {
    home.packages = [ opencode-installer ];

    home.sessionPath = [ "$HOME/.opencode/bin" ];

    home.file.".local/share/opencode/auth.json".text = builtins.toJSON {
      providers = [
        {
          type = "copilot";
          host = githubCopilotHost;
        }
      ];
    };
  };
}

