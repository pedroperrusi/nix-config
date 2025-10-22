{ pkgs, pkgs-unstable, ... }:

{
  home.packages = with pkgs-unstable; [
    # Primary compiler toolchain
    clang

    # GCC tools (without wrapper to avoid conflicts)
    gcc-unwrapped

    # LLVM debugger
    lldb

    # Build tools
    cmake
    gnumake

    # Traditional debugger
    gdb

    # Tools
    pkg-config
    autoconf
    automake
  ];
}
