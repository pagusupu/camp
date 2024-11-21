{lib, ...}: let
  inherit (lib) mkOption types;
  inherit (types) nullOr enum str;
in {
  options.cute.desktop = {
    de = mkOption {
      type = nullOr (enum ["hyprland" "plasma"]);
      default = null;
    };
    monitors = {
      m1 = mkOption {type = str;};
      m2 = mkOption {type = str;};
    };
  };
  config = {
    cute.desktop.monitors = {
      m1 = "DP-3";
      m2 = "HDMI-A-1";
    };
  };
}
