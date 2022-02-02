{
  description = "A Home Manager flake for user";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    flake-utils.url = "github:numtide/flake-utils/master";
  };

  outputs = { self, nixpkgs, home-manager, flake-utils }:
  {
    homeConfigurations = {
      user = home-manager.lib.homeManagerConfiguration {
        system = "x86_64-linux";
        homeDirectory = "/home/user";
        username = "user";
        configuration.imports = [ ./home.nix ];
      };
    };
  } //
  flake-utils.lib.eachDefaultSystem (system:
    let
      pkgs = import nixpkgs { inherit system; };
    in
    {
      devShell = pkgs.mkShell {
        name = "hm-shell";
        packages = [
          home-manager.packages."${system}".home-manager
        ];
      };
  });
}
