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
      shell.enable = true;
    };
    services = {
      deluge.enable = true;
      gitea.enable = true;
      homeassistant.enable = true;
      jellyfin.enable = true;
      komga.enable = true;
      nginx.enable = true;
      nextcloud.enable = false;
      vaultwarden.enable = true;
    };
  };
  time.timeZone = "NZ";
  i18n.defaultLocale = "en_NZ.UTF-8";
  services.openssh = {
    enable = true;
    settings = {
      PermitRootLogin = "no";
    };
  };
  environment = {
    sessionVariables = {FLAKE = "/home/pagu/flake/";};
    variables = {EDITOR = "vim";};
    };
    systemPackages = with pkgs; [
      inputs.agenix.packages.x86_64-linux.default
      alejandra
      flac
      eza
      git
      go
      htop
      hugo
      mdadm
      ranger
      vim
      wget
    ];
  };
  system.stateVersion = "23.11";
}
