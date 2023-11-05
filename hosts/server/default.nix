{
  pkgs,
  lib,
  inputs,
  ...
}: {
  imports = [
    ./hardware.nix
    ./user.nix
    ../../system
  ];
  cute = {
    misc = {
      console.enable = true;
      fonts.enable = false;
      nix.enable = true;
    };
  };
  time.timeZone = "NZ";
  i18n.defaultLocale = "en_NZ.UTF-8";
  services.openssh = {
    enable = true;
    settings = {
      PermitRootLogin = "no";
      # PassowrdAuthentication = true;
    };
  };
  environment = {
    variables = {EDITOR = "vim";};
    shellAliases = {
      ls = "ls --color";
      switch = "cd ~/flake && git pull && sudo nixos-rebuild switch --flake ~/flake/#";
      update = "sudo nix flake update ~/flake && switch";
    };
    systemPackages = with pkgs; [
      inputs.agenix.packages.x86_64-linux.default
      alejandra
      git
      htop
      mdadm
      vim
      wget
      yazi
    ];
  };
  system.stateVersion = "23.11";
}
