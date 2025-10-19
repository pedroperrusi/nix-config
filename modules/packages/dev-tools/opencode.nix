{ pkgs, lib, ... }:

let
  # NOTE: Pin a specific release instead of "latest" for reproducibility.
  # Find tags at: https://github.com/opencode-ai/opencode/releases
  version = "latest"; # ARCHIVED upstream: consider pinning the last available tag when confirmed
  src = pkgs.fetchurl {
  url = "https://github.com/opencode-ai/opencode/releases/latest/download/opencode-linux-x86_64.tar.gz";
  # sha256 fetched via nix-prefetch-url on 2025-10-19
  sha256 = "09c0r7aa9vwgfpmpq43v19nqrkp96k9ic8iyiz2aw83r7qh427vz";
  };
  opencode = pkgs.stdenv.mkDerivation {
    pname = "opencode";
    inherit version src;
    unpackPhase = "tar -xzf $src";
    installPhase = ''
      mkdir -p $out/bin
      cp opencode $out/bin/
      chmod +x $out/bin/opencode
    '';
    meta = with lib; {
      description = "OpenCode - AI coding agent for the terminal";
      homepage = "https://opencode.ai";
      # Validate license in upstream repo; adjust if different.
      license = licenses.asl20;
      maintainers = [];
      platforms = [ "x86_64-linux" ];
      mainProgram = "opencode";
    };
  };
in {
  # Expose as an attribute for inclusion into home.packages from other modules.
  config = {
    home.packages = [ opencode ];
  };
}
