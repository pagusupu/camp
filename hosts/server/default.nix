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
    programs = {
      htop.enable = true;
      nixvim.enable = true;
    };
    services = {
      deluge.enable = true;
      gitea.enable = true;
      homeassistant.enable = false;
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
    systemPackages = with pkgs; [
      inputs.agenix.packages.x86_64-linux.default
      alejandra
      git
      go
      hugo
      mdadm
      wget
#     file management tools
      flac
      rnr
      yazi
#     alternatives
      bat # cat
      eza # ls
      rm-improved # rm
    ];
  };
  system.stateVersion = "23.11";
}
