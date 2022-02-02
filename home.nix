{ pkgs, ... }:
{
  home.packages = with pkgs; [
    ripgrep
    fd
  ];

  # imports = [
  #   # basic tools everyone should want
  #   ./profiles/git
  #   ./profiles/python
  #   ./profiles/tmux
  #   ./profiles/ranger # a nice CLI-based file manager
  # ];
}
