final: prev:
{
  # put new packages/package overrides here
  build-home = prev.writeScriptBin "build-home" ''
    nix build ".#users.physicist.activationPackage" && ./result/activate
  '';
}
