{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "yadunut";
  home.homeDirectory = "/Users/yadunut";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.11"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    pkgs.beancount
    pkgs.coq
    pkgs.delta
    # pkgs.dive
    pkgs.entr
    pkgs.fava
    pkgs.typst
    pkgs.lazygit

    # Neovim deps
    # pkgs.texlab
    # pkgs.efm-langserver

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  programs.zsh.shellAliases = { 
    lg = "lazygit"; 
    s = "kitty +kitten ssh";
  };

  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    nix-direnv.enable = true;
    config = {
      hide_env_diff = true;
    };
  };

  programs.kitty.shellIntegration.enableZshIntegration = true;
  programs.emacs.enable = true;

  programs.neovim.enable = true;

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.git.extraConfig = {
    gpg.ssh.program = "/Applications/1Password.app/Contents/MacOS/op-ssh-sign";
    user.signingkey = "~/.ssh/yadunut_ed25519.pub";
  };

  programs.gh = {
    enable = true;
  };
}
