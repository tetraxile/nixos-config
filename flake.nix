{
  description = "home-manager config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-25.11";
    nixcord.url = "github:FlameFlag/nixcord";
  };

  outputs =
    {
      self,
      nixpkgs,
      nixpkgs-stable,
      ...
    }@inputs:
    let
      overlays = [
        (final: _: {
          stable-pkgs = import nixpkgs-stable {
            system = final.stdenv.hostPlatform.system;
          };
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
            overlaysModule
          ];
        };
      };

      formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.nixfmt-tree;
    };
}
