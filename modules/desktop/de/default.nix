{lib, ...}: {
  options.cute.desktop.de = lib.mkOption {
    type = lib.types.nullOr (lib.types.enum ["hyprland" "plasma"]);
    default = null;
  };
}
