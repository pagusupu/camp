{
  inputs,
  pkgs,
  ...
}: {
  imports = [
    ./hardware.nix
    ./home.nix
    ../../things/misc/system
  ];
  time = {
    timeZone = "NZ";
    hardwareClockInLocalTime = true;
  };
  i18n.defaultLocale = "en_NZ.UTF-8";
  programs = {
    dconf.enable = true;
    steam.enable = true;
    zsh.enable = true;
  };
  services = {
    blueman.enable = true;
    dbus.enable = true;
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
    sudo.wheelNeedsPassword = false;
    tpm2.enable = true;
  };
  fonts = {
    packages = with pkgs; [
      font-awesome
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
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
    systemPackages = with pkgs; [alejandra comma];
    shells = [pkgs.zsh];
  };
  system.stateVersion = "23.11";
}
