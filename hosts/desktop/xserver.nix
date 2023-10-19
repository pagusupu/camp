{
  pkgs,
  config,
  ...
}: {
  services.xserver = {
    enable = true;
    autorun = true;
    xautolock.enable = false;
    excludePackages = [pkgs.xterm];
    libinput.mouse = {
      accelProfile = "flat";
      accelSpeed = "-0.1";
    };
    videoDrivers = ["amdgpu"];
    windowManager.bspwm.enable = true;
    displayManager = {
      defaultSession = "none+bspwm";
      lightdm.greeters.mini = {
        enable = true;
        user = "pagu";
        extraConfig = ''
          [greeter]
          show-password-label = false
          invalid-password-text = Incorrect Password
	  show-input-cursor = false
	  password-alignment = left
          [greeter-theme]
          font = "Nunito"
          text-color = "#${config.cute.colours.primary.fg}"
          error-color = "#${config.cute.colours.normal.red}"
          background-color = "#${config.cute.colours.primary.bg}"
          window-color = "#${config.cute.colours.primary.bg}"
          border-color= "#${config.cute.colours.primary.bg}"
          password-color = "#${config.cute.colours.primary.fg}"
          password-background-color = "#${config.cute.colours.normal.black}"
          password-border-color = "#${config.cute.colours.primary.main}"
          password-border-radius =  0em
          background-image = ""
        '';
      };
    };
    xrandrHeads = [
      {
        output = "DisplayPort-2";
        primary = true;
        monitorConfig = ''
          Modeline "1920x1080x164.96" 384.140 1920 1978 2010 2070    1080 1102 1110 1125 +hsync +vsync
          Option "PreferredMode" "1920x1080x164.96"
        '';
      }
      {
        output = "HDMI-A-0";
        primary = false;
        monitorConfig = ''
          Modeline "1920x1080x74.99" 170.000 1920 1928 1960 2026    1080 1105 1113 1119  +hsync +vsync
          Option "PreferredMode" "1920x1080x74.99"
        '';
      }
    ];
  };
}
