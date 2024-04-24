{ config, pkgs, ... } : 
{
  home.username = "yadunut";
  home.homeDirectory = "/home/yadunut";

  home.packages = with pkgs; [
  ripgrep
  ];

  imports = [
   (import ../modules/zsh.nix)
   (import ../modules/git.nix)
   (import ../modules/neovim.nix)
  ];

  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    nix-direnv.enable = true;
    config = {
      hide_env_diff = true;
    };
  };

  programs.home-manager.enable = true;
  programs.lazygit.enable = true;

  programs.git = {
    extraConfig = {
      user.signingkey = "~/.ssh/id_ed25519.pub";
    };
  };


  programs.tmux = {
    enable = true;
    newSession = true;
    mouse = true;
    keyMode = "vi";
    plugins = with pkgs.tmuxPlugins; [
      sensible
      sessionist
      pain-control
    ];
  };
  programs.zsh.prezto.pmodules = [ "tmux" ];
  programs.zsh.prezto.tmux.autoStartRemote = true;
  programs.fzf.tmux.enableShellIntegration = true;


  home.stateVersion = "23.11";
}

