{lib, ...}: let
  inherit (lib) mkOption types;
  inherit (types) nullOr enum;
in {
  options.cute.desktop.de = mkOption {
    type = nullOr (enum ["hyprland" "plasma"]);
    default = null;
  };
}
