{
  config,
  lib,
  pkgs,
  ...
}: {
  options.cute.wayland.greetd.enable = lib.mkEnableOption "";
  config = lib.mkIf config.cute.wayland.greetd.enable {
    services.greetd = {
      enable = true;
      settings = rec {
        initial_session = {
          command = "${pkgs.hyprland}/bin/Hyprland";
          user = "pagu";
        };
        default_session = initial_session;
      };
    };
  };
}
