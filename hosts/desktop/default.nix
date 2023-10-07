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
      excludePackages = [pkgs.xterm];
      videoDrivers = ["amdgpu"];
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
          #configFile = "${pkgs.bspwm}/share/doc/bspwm/examples/bspwmrc";
          #sxhkd.configFile = "${pkgs.bspwm}/share/doc/bspwm/examples/sxhkdrc";
        };
      };
      xrandrHeads = [
        {
          output = "DP-3";
          primary = true;
          monitorConfig = ''
	    Modeline "1920x1080x165.0" 524.75 1920 2088 2296 2672    1080 1083 1088 1192    -hsync +vsync
            Option "PreferredMode" "1920x1080x165.0"
          '';
        }
        {
	  output = "HDMI-A-1";
	  primary = false;
	  monitorConfig = ''
	    Modeline "1920x1080x75.0" 220.75 1920 2064 2264 2608    1080 1083 1088 1130    -hsync +vsync
	    Option "PreferredMode" "1920x1080x75.0"
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
