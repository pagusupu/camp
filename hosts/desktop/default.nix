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
  time = {
    timeZone = "NZ";
    hardwareClockInLocalTime = true;
  };
  i18n.defaultLocale = "en_NZ.UTF-8";
  programs = {
    git.enable = true;
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
  fonts = {
    packages = with pkgs; [
      nerdfonts
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
      (google-fonts.override {fonts = ["Lato" "Nunito"];})
    ];
    fontconfig = {
      defaultFonts = {
        serif = ["Lato"];
        sansSerif = ["Nunito"];
        monospace = ["FiraCode Nerd Font"];
      };
    };
  };
  environment = {
    shells = with pkgs; [zsh];
    systemPackages = with pkgs; [alejandra];
    defaultPackages = lib.mkForce [];
  };
  system.stateVersion = "23.11";
}
