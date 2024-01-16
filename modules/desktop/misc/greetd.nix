{
  config,
  lib,
  pkgs,
  ...
}: {
  options.cute.desktop.misc.greetd.enable = lib.mkEnableOption "";
  config = lib.mkIf config.cute.desktop.misc.greetd.enable {
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
