{ config, pkgs, ... } : 
{
  home.username = "yadunut";
  home.homeDirectory = "/home/yadunut";

  home.packages = with pkgs; [
  ripgrep
  ];

  programs.starship.enable = true;
  programs.home-manager.enable = true;

  home.stateVersion = "23.11";
}

