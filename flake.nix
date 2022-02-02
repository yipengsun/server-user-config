{
  description = "A Home Manager flake for user";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, home-manager, flake-utils }:
    rec {
      overlay = import ./overlay/default.nix;
      users = {
        physicist = home-manager.lib.homeManagerConfiguration {
          system = "x86_64-linux";
          stateVersion = "21.11"; # typically you don't change this

          # change these yourself
          homeDirectory = "/home/physicist";
          username = "physicist";

          configuration = { pkgs, lib, ... }: {
            nixpkgs.overlays = [ overlay ];

            home.packages = with pkgs; [
              # basic utilities
              ripgrep
              fd

              # HEP
              root

              # define additional packages here
              # you can search the package names on https://search.nixos.org/packages
            ];

            imports = [
              # basic tools everyone should want
              ./profiles/git
              ./profiles/python
              ./profiles/tmux # screen replacement
              ./profiles/fzf # fuzzy find
              ./profiles/ranger # a nice CLI-based file manager

              # shell
              ./profiles/zsh

              # dev
              ./profiles/neovim
              ./profiles/bat

              # config
              ./profiles/dircolors
            ];
          };
        };
      };
    } //
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          config = { allowUnfree = true; };
          overlays = [ self.overlay ];
        };
      in
      {
        devShell = pkgs.mkShell {
          buildInputs = with pkgs; [
            build-home
          ];
        };
      });
}
