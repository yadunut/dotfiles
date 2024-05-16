{ config, lib, pkgs, inputs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  nix.settings.experimental-features = ["nix-command" "flakes" ];

  networking.hostName = "nixos"; # Define your hostname.

  users.users.yadunut = {
    shell = pkgs.zsh;
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
    openssh.authorizedKeys.keys = [ "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJXOpmWsAnl2RtOuJJMRUx+iJTwf2RWJ1iS3FqXJFzFG" ];
  };
  security.sudo.wheelNeedsPassword = false;

  environment.systemPackages = with pkgs; [
    git
    neovim
    wget
    inputs.agenix.packages."${pkgs.system}".default
  ];

  age.secrets.tailscale.file = ./secrets/tailscale.age;


  programs.zsh.enable = true;
  # List services that you want to enable:

  # Enable the OpenSSH daemon.

  services.qemuGuest.enable = true;
  services.openssh.enable = true;
  services.tailscale = {
    enable = true;
    authKeyFile = config.age.secrets.tailscale.path;
    extraUpFlags = [ "--login-server" "http://ts.yadunut.com:444" ];
  };
  environment.variables.EDITOR = "nvim";

  nixpkgs.config.allowUnfree = true;

  hardware.opengl = {
    enable = true;
  };

  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = false;
    powerManagement.finegrained = false;
    open = false;
    nvidiaSettings = false;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };
  # Need this for nvidia-smi
  services.xserver.videoDrivers = [ "nvidia" ];

  system.stateVersion = "23.11"; # Did you read the comment?

}

