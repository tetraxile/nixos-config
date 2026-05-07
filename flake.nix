{
  description = "home-manager config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-25.11";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixcord = {
      url = "github:FlameFlag/nixcord";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    zen-browser = {
      url = "github:youwen5/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      nixpkgs-stable,
      zen-browser,
      nix-index-database,
      ...
    }@inputs:
    let
      overlays = [
        (final: _: {
          stable-pkgs = import nixpkgs-stable {
            system = final.stdenv.hostPlatform.system;
          };
          zen-browser = zen-browser.packages.${final.stdenv.hostPlatform.system}.default;
        })
      ];
      overlaysModule = _: { nixpkgs.overlays = overlays; };
    in
    {
      packages.x86_64-linux = import ./packages (
        import nixpkgs {
          system = "x86_64-linux";

          specialArgs = {
            inherit inputs;
          };

          config = {
            allowUnfree = true;
            allowInsecurePredicate = pkg: true;
          };
        }
      );

      nixosConfigurations = {
        catbox = nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit inputs;
            isDesktop = true;
            hostName = "catbox";
          };
          modules = [
            ./configuration.nix
            inputs.home-manager.nixosModules.default
            nix-index-database.nixosModules.default
            overlaysModule
          ];
        };
        dovecote = nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit inputs;
            isDesktop = true;
            hostName = "dovecote";
          };
          modules = [
            ./configuration.nix
            inputs.home-manager.nixosModules.default
            nix-index-database.nixosModules.default
            overlaysModule
          ];
        };
      };

      formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.nixfmt-tree;
    };
}
