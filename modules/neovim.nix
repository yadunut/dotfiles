{ config, pkgs, ... }:
{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    # extraLuaConfig = '' '';
    # extraPackages = [ ];
  };
}
