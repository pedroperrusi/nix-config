{ pkgs, lib, ... }:

{
  home.packages = with pkgs; [
    obsidian
  ];

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
