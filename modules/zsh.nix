{
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    zsh-completions
    fd
    htop
    ripgrep
    wget
  ];
  programs.bat = {
    enable = true;
  };
  programs.dircolors = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.zsh = {
    enable = true;
    history = {
      size = 1000000;
      extended = true;
      append = true;
      expireDuplicatesFirst = true;
      ignoreDups = true;
      ignoreAllDups = true;
      ignoreSpace = true;
    };
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
      cat = "bat --theme=\"$(defaults read -globalDomain AppleInterfaceStyle &> /dev/null && echo 'gruvbox-dark' || echo 'gruvbox-light')\"";

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
    settings = {
      nodejs.disabled = true;
      package.disabled = true;
      aws.disabled = true;
    };
  };
}
