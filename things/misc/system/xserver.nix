{pkgs, ...}: {
  services.xserver = {
    enable = true;
    autorun = true;
    excludePackages = [pkgs.xterm];
    videoDrivers = ["amdgpu"];
    windowManager.bspwm.enable = true;
    displayManager = {
      defaultSession = "none+bspwm";
      lightdm.greeters.mini = {
        enable = true;
        user = "pagu";
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
