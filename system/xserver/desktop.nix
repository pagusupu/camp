{
  pkgs,
  config,
  ...
}: {
  options.cute.xserver.desktop = {
    enable = lib.mkEnableOption "";
  };
  config = lib.mkIf config.cute.xserver.desktop.enable {
    services.xserver = {
      enable = true;
      autorun = true;
      xautolock.enable = false;
      excludePackages = [pkgs.xterm];
      videoDrivers = ["amdgpu"];
      displayManager.defaultSession = "none+bspwm";
      windowManager.bspwm.enable = true;
      libinput.mouse = {
        accelProfile = "flat";
        accelSpeed = "-0.1";
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
  };
}
