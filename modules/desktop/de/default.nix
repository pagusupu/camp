{
  config,
  lib,
  ...
}: let
  inherit (lib) mkOption types;
  inherit (types) nullOr enum str;
in {
  options.cute.desktop = {
    de = mkOption {
      type = nullOr (enum [ "hyprland" "plasma" ]);
      default = null;
    };
    monitors = {
      m1 = mkOption { type = str; };
      m2 = mkOption { type = str; };
    };
    theme = mkOption {
      default = "light";
      type = enum [ "dark" "light" ];
    };
  };
  config = lib.mkMerge [
    {
      cute.desktop.monitors = {
        m1 = "DP-3";
        m2 = "HDMI-A-1";
      };
    }
    (lib.mkIf config.cute.dark {
      specialisation.dark.configuration = {
        cute.desktop.theme = "dark";
      };
    })
  ];
}
