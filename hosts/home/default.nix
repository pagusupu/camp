{
  inputs,
  pkgs,
  ...
}: {
  imports = [
    ./hardware.nix
    ./user.nix
    ../../things/misc/nix.nix
    ../../things/misc/console.nix
    ../../things/misc/greetd.nix
  ];
  time = {
    timeZone = "NZ";
    hardwareClockInLocalTime = true;
  };
  i18n.defaultLocale = "en_NZ.UTF-8";
  programs = {
    zsh.enable = true;
    steam.enable = true;
    hyprland = {
      enable = true;
      package = inputs.hyprland.packages.${pkgs.system}.hyprland;
    };
  };
  services = {
    dbus.enable = true;
    blueman.enable = true;
    greetd.enable = true;
    pipewire = {
      enable = true;
      alsa.enable = true;
      pulse.enable = true;
    };
  };
  security = {
    pam.services.swaylock = {};
    rtkit.enable = true;
    tpm2.enable = true;
    sudo.wheelNeedsPassword = false;
  };
  fonts = {
    packages = with pkgs; [
      noto-fonts
      line-awesome
      (google-fonts.override {fonts = ["Nunito" "Lato" "Kosugi Maru" "Fira Code"];})
    ];
    fontconfig = {
      defaultFonts = {
        serif = ["Lato"];
        sansSerif = ["Nunito" "Kosugi Maru"];
        monospace = ["FiraCode"];
      };
    };
  };
  environment = {
    systemPackages = with pkgs; [alejandra];
    shells = [pkgs.zsh];
  };
  system.stateVersion = "23.11";
}
