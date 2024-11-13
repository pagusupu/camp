{
  config,
  lib,
  cutelib,
  pkgs,
  ...
}:
lib.mkIf (config.cute.desktop.de == "hyprland") {
  assertions = cutelib.assertHm "hyprland-login";
  services.greetd = {
    enable = true;
    settings = rec {
      initial_session = {
        command = "${lib.getExe pkgs.hyprland}";
        user = "pagu";
      };
      default_session = initial_session;
    };
  };
  home-manager.users.pagu = {
    home.packages = [pkgs.hyprpolkitagent];
    wayland.windowManager.hyprland.settings.exec-once = [
      "systemctl --user start hyprpolkitagent"
    ];
  };
}
