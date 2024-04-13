{ config, pkgs, ... }: 
{

  home.packages = [
  pkgs.zsh-completions
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
      lg = "lazygit";
      cat = "bat";
      diff = "delta";
      s = "kitty +kitten ssh";
    };
  };

  programs.starship = {
    enable = true;
    enableZshIntegration = true;
  };
}
