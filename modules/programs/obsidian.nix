{ pkgs, lib, ... }:

let
  vaultPath = "$HOME/Documents/Obsidian/Pedroverso";
  obsidianWithVault = pkgs.writeShellScriptBin "obsidian-pedroverso" ''
    ${pkgs.obsidian}/bin/obsidian "obsidian://open?path=${vaultPath}"
  '';
in
{
  home.packages = with pkgs; [
    obsidian
    obsidianWithVault
  ];

  # Desktop entry for Obsidian with vault auto-open
  xdg.desktopEntries.obsidian-pedroverso = {
    name = "Obsidian (Pedroverso)";
    genericName = "Note Taking App";
    comment = "Open Obsidian with Pedroverso vault";
    exec = "${obsidianWithVault}/bin/obsidian-pedroverso";
    icon = "obsidian";
    terminal = false;
    categories = [ "Office" "TextEditor" ];
    type = "Application";
  };

  # Obsidian configuration directory is typically ~/.config/obsidian
  # Vault locations are user-defined and can be anywhere
   # To automatically clone/sync vaults, you could use home.activation scripts
  # or rely on Obsidian's built-in sync or git-based solutions

  home.activation.cloneObsidianVault = lib.hm.dag.entryAfter ["writeBoundary"] ''
    VAULT_DIR="$HOME/Documents/Obsidian/Pedroverso"
    if [ ! -d "$VAULT_DIR" ]; then
      PATH="${pkgs.openssh}/bin:${pkgs.git}/bin:$PATH"
      $DRY_RUN_CMD mkdir -p "$(dirname "$VAULT_DIR")"
      $DRY_RUN_CMD ${pkgs.git}/bin/git clone git@github.com:pedroperrusi/obsidian-pedroverso.git "$VAULT_DIR"
    fi
  '';
}
