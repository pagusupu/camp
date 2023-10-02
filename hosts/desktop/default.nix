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
    greetd.enable = false;
    pipewire = {
      enable = true;
      alsa.enable = true;
      pulse.enable = true;
    };
    xserver = {
      enable = true;
      autorun = true;
      desktopManager.xterm.enable = false;
      displayManager = {
        defaultSession = "none+bspwm";
        lightdm.greeters.mini = {
          enable = true;
          user = "pagu";
        };
      };
      windowManager = {
        bspwm = {
          enable = true;
          configFile = "${pkgs.bspwm}/share/doc/bspwm/examples/bspwmrc";
          sxhkd.configFile = "${pkgs.bspwm}/share/doc/bspwm/examples/sxhkdrc";
        };
      };
      videoDrivers = ["amdgpu"];
      xrandrHeads = [
        {
          output = "DP-3";
          primary = true;
          monitorConfig = ''
            Option "PreferredMode" "1920x1080_164.76"
          '';
        }
        {
          output = "HDMI-A-1";
          primary = false;
          monitorConfig = ''
            Option "PreferredMode" "1920x1080_74.91"
          '';
        }
      ];
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
      (google-fonts.override {fonts = ["Fira Code" "Kosugi Maru" "Lato" "Nunito"];})
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
    systemPackages = with pkgs; [alejandra];
    shells = with pkgs; [zsh];
  };
  system.stateVersion = "23.11";
}
