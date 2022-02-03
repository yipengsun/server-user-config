final: prev:
{
  # put new packages/package overrides here
  home-build = prev.writeScriptBin "home-build" ''
    nix build ".#users.physicist.activationPackage"
  '';
  home-switch = prev.writeScriptBin "home-switch" ''
    ${final.home-build}/bin/home-build && ./result/activate
  '';
}
