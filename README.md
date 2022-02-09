# server-user-config [![github CI](https://github.com/umd-lhcb/server-user-config/workflows/CI/badge.svg?branch=master)](https://github.com/umd-lhcb/server-user-config/actions?query=workflow%3ACI)
Sample nix-based user config for our server.


## Usage

1. **Fork** this repo under your own name

2. Setup `ssh` on the server:
    1. `mkdir ~/.ssh && chmod 700 ~/.ssh`
    2. Copy your `~/.ssh/id_rsa.pub` to the server as `~/.ssh/authorized_keys`
    3. `chmod 600 ~/.ssh/authorized_keys`
    4. Copy your private key: `~/.ssh/id_rsa` to the server as `~/.ssh/id_rsa`
    5. `chmod 600 ~/.ssh/id_rsa`

3. Clone your fork of this repo somewhere on the server, with `ssh` protocol
4. In `flake.nix`, change these based on your user config:

    ```nix
    # change these yourself
    homeDirectory = "/home/physicist";
    username = "physicist";
    ```

5. In `profiles/git/default.nix`, change:

    ```nix
    user.name = "Physicist";
    user.email = "lhcb@physics.umd.edu";
    ```

6. If you want to install new packages, change `flake.nix`:

    ```nix
    home.packages = with pkgs; [
      # ...

      # define additional packages here
      # you can search the package names on https://search.nixos.org/packages
    ];
    ```

7. `nix develop -c home-switch`
8. `chsh -s $(which zsh)`
9. Logout and re-login. Enjoy!
