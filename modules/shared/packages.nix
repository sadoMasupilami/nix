{ pkgs }:

with pkgs; [
  # General packages for development and system management
  openssh
  wget
  zip

  # Text and terminal utilities
  htop
  iftop
  jq
  tree
  zsh-powerlevel10k

  eza
  meslo-lgs-nf

  direnv
  unixtools.ifconfig
  unixtools.netstat
]
