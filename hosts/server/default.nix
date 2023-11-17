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
      nix.enable = true;
    };
    services = {
      deluge.enable = true;
      gitea.enable = true;
      homeassistant.enable = true;
      jellyfin.enable = true;
      komga.enable = true;
      nginx.enable = true;
      vaultwarden.enable = true;
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
      switch = "sudo nixos-rebuild switch --flake ~/flake/#";
      update = "sudo nix flake update ~/flake && switch";
    };
    systemPackages = with pkgs; [
      inputs.agenix.packages.x86_64-linux.default
      alejandra
      flac
      git
      go
      htop
      hugo
      mdadm
      ueberzugpp
      vim
      wget
      yazi
    ];
  };
  system.stateVersion = "23.11";
}
