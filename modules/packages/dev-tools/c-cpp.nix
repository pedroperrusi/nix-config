{ pkgs, pkgs-unstable, ... }:

{
  home.packages = with pkgs-unstable; [
    # Compilers
    gcc
    clang

    # Build tools
    cmake
    gnumake

    # Debugger
    gdb

    # Tools
    pkg-config
    autoconf
    automake
  ];
}
