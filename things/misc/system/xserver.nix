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
        output = "DP-3";
        primary = true;
        monitorConfig = ''
          Modeline "1920x1080x165.0" 524.75 1920 2088 2296 2672    1080 1083 1088 1192 -hsync +vsync
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
}
