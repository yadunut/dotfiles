{ config, pkgs, inputs, ... }:
{
  home.packages = [
    pkgs.comic-mono
  ];
  programs.wezterm = {
    enable = true;
    extraConfig = builtins.readFile ./wezterm.lua;
  };
}