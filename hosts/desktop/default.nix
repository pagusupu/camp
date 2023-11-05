{
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./hardware.nix
    ./user.nix
    ./xserver.nix
    ../../system
  ];
  cute.misc = {
    console.enable = true;
    fonts.enable = true;
    nix.enable = true;
  };
  time = {
    timeZone = "NZ";
    hardwareClockInLocalTime = true;
  };
  i18n.defaultLocale = "en_NZ.UTF-8";
  programs = {
    nano.enable = false;
    steam.enable = true;
    zsh.enable = true;
  };
  services = {
    blueman.enable = true;
    dbus.enable = true;
    pipewire = {
      enable = true;
      alsa.enable = true;
      pulse.enable = true;
    }; 
  };
  security = {
    rtkit.enable = true;
    tpm2.enable = true;
    sudo = {
      execWheelOnly = true;
      wheelNeedsPassword = false;
    };
  };
  environment = {
    shells = with pkgs; [zsh];
    defaultPackages = lib.mkForce [];
    systemPackages = with pkgs; [alejandra];
  };
  system.stateVersion = "23.11";
}
