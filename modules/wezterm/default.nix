{
  config,
  pkgs,
  inputs,
  ...
}: {
  home.packages = [
    pkgs.comic-mono
  ];
  programs.wezterm = {
    enable = false;
    extraConfig = builtins.readFile ./wezterm.lua;
  };
}
