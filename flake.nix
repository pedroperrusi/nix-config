{
  description = "Pedro • Pure Nix Home Manager: packages + dotfiles (no chezmoi)";

  inputs = {
    # Stable channels for reproducibility
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    home-manager.url = "github:nix-community/home-manager/release-24.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, home-manager, ... }:
  let
    system = "x86_64-linux";
    pkgs = import nixpkgs { inherit system; };

  in {
    # Home Manager target for your Ubuntu workstation
    homeConfigurations."pedro@work-ubuntu" =
      home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
          ./home/work-ubuntu.nix
        ];
      };

    # Example for a future macOS config (uncomment + copy your module)
    # homeConfigurations."pedro@mac" =
    #   home-manager.lib.homeManagerConfiguration {
    #     pkgs = import nixpkgs { system = "aarch64-darwin"; };
    #     modules = [ ./home/mac.nix ];
    #   };
  };
}