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
        homeDirectory = "/home/physicist";
        username = "physicist";

        configuration = { pkgs, lib, ... }: {
          home.packages = with pkgs; [
            # basic utilities
            ripgrep
            bat # cat with syntax highlighting
            fd
          ];

          imports = [
            # basic tools everyone should want
            ./profiles/git
            ./profiles/python
            ./profiles/tmux
            ./profiles/ranger # a nice CLI-based file manager
          ];
        };
      };
    };
  };
}
