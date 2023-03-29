{
  description = "Sample nix-based user config for our server";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, home-manager, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        overlay = import ./overlay/default.nix;
        pkgs = import nixpkgs {
          inherit system;
          config = { allowUnfree = true; };
          overlays = [ overlay ];
        };
      in
      {
        devShell = pkgs.mkShell {
          name = "server-user-config-devshell";
          buildInputs = with pkgs; [
            home-build
            home-switch
          ];
        };

        users = {
          physicist = home-manager.lib.homeManagerConfiguration {
            inherit pkgs;

            stateVersion = "21.11"; # typically you don't change this

            # change these yourself
            homeDirectory = "/home/syp";
            username = "syp";

            configuration = { pkgs, lib, ... }: {
              home.packages = with pkgs; [
                pkgs.home-manager

                # basic utilities
                bottom # bottom is top
                ripgrep
                fd
                tree
                git-annex

                # terminal debugging
                colortest

                # HEP
                root
                sxiv # image viewer
                zathura # pdf viewer

                # dev
                nixpkgs-review
                black

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
                ./profiles/direnv
                ./profiles/bat # cat with syntax highlighting
                ./profiles/neovim # vi

                # config
                ./profiles/dircolors
              ];
            };
          };
        };
      });
}
