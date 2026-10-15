{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    krita-custom.url = "nixpkgs/6368eda62c9775c38ef7f714b2555a741c20c72d";
    opencode.url = "github:GutMutCode/opencode-nix";
    zen-browser = {
      url = "github:youwen5/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      krita-custom,
      zen-browser,
      opencode,
      ...
    }@inputs:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          ./configuration.nix
          home-manager.nixosModules.home-manager
          {
            nixpkgs.overlays = [ opencode.overlays.default ];

            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.nix = import ./home.nix;
              backupFileExtension = "backup";

              extraSpecialArgs = {
                krita-custom = krita-custom.legacyPackages.${system}.krita;
                zen-browser = zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default;
              };

            };
          }
        ];
      };
    };
}
