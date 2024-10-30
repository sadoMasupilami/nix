{ pkgs }:

with pkgs;
let shared-packages = import ../shared/packages.nix { inherit pkgs; }; in
shared-packages ++ [

  home-manager
  direnv
  tree
  unixtools.ifconfig
  unixtools.netstat
]
