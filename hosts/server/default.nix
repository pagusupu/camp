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
  services.openssh.enable = true;
  environment = {
    sessionVariables = {FLAKE = "/home/pagu/flake/";};
    variables = {EDITOR = "vim";};
    systemPackages = with pkgs; [
      inputs.agenix.packages.x86_64-linux.default
      alejandra
      bat
      bottom
      eza
      flac
      git
      go
      htop
      hugo
      mdadm
      rm-improved
      rnr
      vim
      wget
      yazi
    ];
  };
  system.stateVersion = "23.11";
}
