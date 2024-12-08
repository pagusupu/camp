{
  config,
  lib,
  cutelib,
  pkgs,
  ...
}:
lib.mkIf (config.cute.desktop.de == "hyprland") {
  assertions = cutelib.assertHm "hyprland";
  programs.hyprland.enable = true;
  home-manager.users.pagu = {
    wayland.windowManager.hyprland = {
      enable = true;
      settings = {
        exec-once = [
          "waybar"
          "mako"
        ];
        env = [
          "_JAVA_AWT_WM_NONREPARENTING,1"
          "NIXOS_OZONE_WL,1"
        ];
        monitor = let
          inherit (config.cute.desktop.monitors) m1 m2;
        in [
          "${m1}, 1920x1080@144, 0x0, 1"
          "${m2}, 1920x1080@144, 1920x0, 1"
        ];
        misc.vrr = 1;
      };
      systemd.variables = [ "--all" ];
    };
    home.packages = with pkgs; [
      kooha
      wl-clipboard
    ];
    programs.mpv.enable = true;
  };
  cute.desktop.wm = {
    mako = true;
    waybar = true;
    wlogout = true;
    wofi = true;
  };
}
