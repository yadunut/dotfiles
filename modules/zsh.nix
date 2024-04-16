{ config, pkgs, ... }: 
{

  home.packages = [
  pkgs.zsh-completions
    pkgs.bat
    pkgs.fd
    pkgs.htop
    pkgs.ripgrep
    pkgs.wget
  ];
  programs.zsh = {
    enable = true;
    prezto = {
      enable = true;
      editor.keymap = "vi";
      editor.dotExpansion = true;
      pmodules = [
        "environment"
        "terminal"
        "utility"
        "directory"
        "editor"
        "history"
        "syntax-highlighting"
        "history-substring-search"
        "autosuggestions"
        "completion"
      ];
     };
    shellAliases = {
      cat = "bat";
      diff = "delta";
    };
  };

  programs.fzf.enable = true;
  programs.fzf.enableZshIntegration = true;

  programs.zoxide.enable = true;
  programs.zoxide.enableZshIntegration = true;

  programs.eza.enable = true;
  programs.eza.enableZshIntegration = true;

  programs.starship = {
    enable = true;
    enableZshIntegration = true;
  };
}
