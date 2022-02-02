{
  description = "A Home Manager flake for user";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, home-manager }: {
    users = {
      physicist = home-manager.lib.homeManagerConfiguration {
        system = "x86_64-linux";
        stateVersion = "21.11"; # typically you don't change this

        # change these yourself
        homeDirectory = "/home/user";
        username = "user";

        configuration = { pkgs, lib, ... }: {
          imports = [ ./home.nix ];
        };
      };
    };
  };
}
