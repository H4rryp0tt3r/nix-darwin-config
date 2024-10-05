{
  description = "nix-darwin configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    mac-app-util.url = "github:hraban/mac-app-util";
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, home-manager, mac-app-util }:
    let gitRev = self.rev or self.dirtyRev or "unknown-rev";
    in
    {
      # Build darwin flake using:
      # $ darwin-rebuild build --flake .#H4rryp0tt3r-MacBook
      darwinConfigurations."H4rryp0tt3r-MacBook" = nix-darwin.lib.darwinSystem {
        modules = [
          ./darwin.nix
          mac-app-util.darwinModules.default
          home-manager.darwinModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.verbose = true;
            home-manager.users."h4rryp0tt3r" = import ./home.nix;
            home-manager.sharedModules = [
              mac-app-util.homeManagerModules.default
            ];
          }
        ];
        specialArgs = { inherit gitRev; };
      };

      # Expose the package set, including overlays, for convenience.
      darwinPackages = self.darwinConfigurations."H4rryp0tt3r-MacBook".pkgs;
    };
}
