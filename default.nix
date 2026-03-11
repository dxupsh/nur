  { pkgs ? import <nixpkgs> { } }:

  {
    dxup = pkgs.callPackage ./pkgs/dxup { };
  }
