{ config, pkgs, ... } : 
{
  home.username = "yadunut";
  home.homeDirectory = "/home/yadunut";

  home.packages = with pkgs; [
  ripgrep
  ];

  programs.zsh.enable = true;
  programs.zoxide.enable = true;
  programs.zoxide.enableZshIntegration = true;
  programs.starship.enable = true;
  programs.home-manager.enable = true;
  programs.lazygit.enable = true;

  programs.git = {
    enable = true;
    userName = "Yadunand Prem";
    userEmail = "yadunand@yadunut.com";
    delta.enable = true;
    lfs.enable = true;
    extraConfig = {
      commit.gpgsign = true;
      gpg.format = "ssh";
      user.signingkey = "~/.ssh/id_ed25519.pub";
    };
  };

  home.stateVersion = "23.11";
}

