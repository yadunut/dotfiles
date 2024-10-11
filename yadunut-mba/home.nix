{ config, pkgs, inputs, lib, ... }:

{
  imports = [
    ../modules/zsh.nix
    ../modules/neovim.nix
    ../modules/git.nix
    ../modules/wezterm
  ];
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
  home.stateVersion = "24.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    pkgs.lazygit
    pkgs.jq
    pkgs.cocoapods
    pkgs.entr
    pkgs.gh
    pkgs.zellij
    pkgs.httpie


    pkgs.emacs
    pkgs.wezterm
    pkgs.arc-browser
    pkgs.raycast
    pkgs.tailscale
    pkgs.vscode
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

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
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/yadunut/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    JAVA_HOME="/Library/Java/JavaVirtualMachines/zulu-17.jdk/Contents/Home";
    ANDROID_HOME="$HOME/Library/Android/sdk";
    EDITOR="nvim";
    VISUAL="nvim";
  };
  home.sessionPath = [
    "$ANDROID_HOME/emulator"
    "$ANDROID_HOME/platform-tools"
  ];
  programs.zsh.shellAliases = { 
    lg = "lazygit"; 
  };

  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    nix-direnv.enable = true;
    config = {
      hide_env_diff = true;
    };
  };

  programs.zellij = {
    enable = true;
    settings = {
      theme = "gruvbox-light";
      themes = {
        solarized-light = {
          fg = "#657b83";
          bg = "#fdf6e3";
          black = "#073642";
          red = "#dc322f";
          green = "#859900";
          yellow = "#b58900";
          blue = "#268bd2";
          magenta = "#d33682";
          cyan = "#2aa198";
          white = "#eee8d5";
          orange = "#cb4b16";
        };
        gruvbox-light = {
          bg="#d5c4a1";
          fg="#504945";
          orange="#980005";
          green="#79740e";
          yellow="#d79921";
          blue="#458588";
          magenta="#b16286";
          cyan="#689d6a";
          black="#ebdbb2";
          white="#3c3836";
          red="#d65d0e";
        };
        gruvbox-dark = {
          fg="#ebdbb2";
          bg="#504945";
          black="#3c3836";
          red="#cc241d";
          green="#98971a";
          yellow="#d79921";
          blue="#458588";
          magenta="#b16286";
          cyan="#689d6a";
          white="#fbf1c7";
          orange="#d65d0e";
        };
      };
    };
  };

  programs.git.extraConfig = {
    gpg.ssh.program = "/Applications/1Password.app/Contents/MacOS/op-ssh-sign";
    core.excludesFile = "~/.gitignore_global";
    user.signingkey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILVE2J91NjPye2rWjQce6LmSfiHBwJVvgt1U3qoMW5zi";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  programs.bat.config.theme = lib.mkForce "gruvbox-light";
}
