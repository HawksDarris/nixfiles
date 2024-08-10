# [[file:../README.org::*Jurism][Jurism:1]]
{
  pkgs ? import (fetchTarball {
    url = "https://jurism.xyz/jurism/dl?channel=release&platform=linux-x86_64";
    sha256 = lib.fakeSha256; # lib.fakeSha256 passes fake hash so build step will reveal real hash
  }) {}
}:
pkgs.stdenv.mkDerivation rec {
  pname = "Jurism";
  version = "6.0";

  src = pkgs.fetchgit {
    url = "https://gitlab.inria.fr/nix-tutorial/chord-tuto-nix-2022";
    rev = "069d2a5bfa4c4024063c25551d5201aeaf921cb3";
    sha256 = "sha256-MlqJOoMSRuYeG+jl8DFgcNnpEyeRgDCK2JlN9pOqBWA=";
  };

  buildInputs = [
    pkgs.simgrid
    pkgs.boost
    pkgs.cmake
  ];

  configurePhase = ''
    cmake .
  '';

  buildPhase = ''
    make
  '';

  installPhase = ''
    mkdir -p $out/bin
    mv chord $out/bin
  '';
}
# Jurism:1 ends here
