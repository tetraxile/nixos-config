{
  description = "home-manager config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    home-manager.url = "github:nix-community/home-manager/release-25.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs, ... }@inputs: {
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
  };
}
