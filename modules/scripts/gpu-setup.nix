{ pkgs, ... }:

{
  home.packages = [
    # Script to install nixGL system-wide (run once manually)
    (pkgs.writeShellScriptBin "install-nixgl" ''
      echo "Installing nixGL for OpenGL support..."
      echo ""
      echo "Run this command:"
      echo "  nix-channel --add https://github.com/nix-community/nixGL/archive/main.tar.gz nixgl"
      echo "  nix-channel --update"
      echo "  nix-env -iA nixgl.auto.nixGLDefault"
      echo ""
      echo "After installation, use: ghostty-gl"
    '')
    
    # Alternative: Install nixpkgs.nixgl if available
    (pkgs.writeShellScriptBin "setup-gpu-terminals" ''
      #!/usr/bin/env bash
      set -e
      
      echo "Setting up GPU terminal support..."
      
      # Check if nixGL is already installed
      if command -v nixGL &> /dev/null; then
        echo "✓ nixGL is already installed"
      else
        echo "Installing nixGL..."
        nix-env -iA nixpkgs.nixgl.auto.nixGLDefault 2>/dev/null || {
          echo "Failed to install from nixpkgs, trying channel method..."
          nix-channel --add https://github.com/nix-community/nixGL/archive/main.tar.gz nixgl
          nix-channel --update
          nix-env -iA nixgl.auto.nixGLDefault
        }
      fi
      
      echo ""
      echo "✓ Setup complete!"
      echo ""
      echo "Now you can use:"
      echo "  ghostty-gl    - Ghostty with GPU support"
      echo "  nixGL ghostty - Manual wrapper"
    '')
  ];
}
