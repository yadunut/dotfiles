{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    (import ../modules/zsh.nix)
    (import ../modules/git.nix)
    (import ../modules/neovim.nix)
    (import ../modules/wezterm)
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
  home.stateVersion = "23.11"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    # pkgs.dive
    pkgs.entr

    pkgs.typst
    pkgs.tinymist

    pkgs.lazygit
    pkgs.jq
    pkgs.nixfmt-rfc-style
    pkgs.just
    pkgs.rsync
    pkgs.nil # nix lsp
    pkgs.vscode-langservers-extracted
    pkgs.zellij
    pkgs.gh
    pkgs.deno

    pkgs.rust-analyzer
    pkgs.claude-code
    pkgs.httpie
    pkgs.emacs
    pkgs.devenv

    # (inputs.ziggy.outputs.packages.aarch64-darwin.ziggy)
    # (inputs.superhtml.outputs.packages.aarch64-darwin.superhtml)

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
    VISUAL = "nvim";
    JAVA_HOME = "/Library/Java/JavaVirtualMachines/zulu-17.jdk/Contents/Home";
    ANDROID_HOME = "$HOME/Library/Android/sdk";
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

  programs.kitty.shellIntegration.enableZshIntegration = true;

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.git.extraConfig = {
    gpg.ssh.program = "/Applications/1Password.app/Contents/MacOS/op-ssh-sign";
    user.signingkey = "~/.ssh/yadunut_ed25519.pub";
    core.excludesFile = "~/.gitignore_global";
  };

  programs.gh = {
    enable = true;
  };

  targets.darwin = {
    defaults."com.apple.dock".autohide = true;
    defaults."com.apple.finder".AppleShowAllFiles = true;
    defaults.NSGlobalDomain.AppleShowAllExtensions = true;
    defaults.NSGlobalDomain.KeyRepeat = 2;
    defaults.NSGlobalDomain.ApplePressAndHoldEnabled = false;
  };

}
