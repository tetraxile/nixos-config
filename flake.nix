{
  description = "home-manager config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    # nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    zen-browser = {
      url = "github:youwen5/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      ...
    }@inputs:
    {
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
          ];
        };
      };

      formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.nixfmt-tree;
    };
}
