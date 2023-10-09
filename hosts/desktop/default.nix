{
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
    git.enable = true;
    steam.enable = true;
    zsh.enable = true;
  };
  services = {
    blueman.enable = true;
    dbus.enable = true;
    greetd.enable = false;
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
      nerdfonts
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
      (google-fonts.override {fonts = ["Fira Code" "Lato" "Nunito" "Kosugi Maru"];})
    ];
    fontconfig = {
      defaultFonts = {
        serif = ["Lato"];
        sansSerif = ["Nunito" "Kosugi Maru"];
        monospace = ["Fira Code"];
      };
    };
  };
  environment = {
    shells = with pkgs; [zsh];
    systemPackages = with pkgs; [alejandra];
  };
  system.stateVersion = "23.11";
}
