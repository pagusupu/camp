{
  config,
  lib,
  pkgs,
  ...
}: {
  options.cute.desktop.de.gnome = lib.mkEnableOption "";
  config = lib.mkIf config.cute.desktop.de.gnome {
    services.xserver = {
      enable = true;
      displayManager.gdm.enable = true;
      desktopManager.gnome.enable = true;
    };
    environment.gnome.excludePackages =
      (builtins.attrValues {
        inherit
          (pkgs)
          gnome-photos
          gnome-tour
          gnome-text-editor
          ;
      })
      ++ (builtins.attrValues {
        inherit
          (pkgs.gnome)
          cheese
          gnome-music
          gnome-terminal
          epiphany
          geary
          evince
          gnome-characters
          totem
          tali
          iagno
          hitori
          atomix
          gnome-calculator
          yelp
          gnome-maps
          gnome-weather
          gnome-contacts
          simple-scan
          ;
      });
  };
}
