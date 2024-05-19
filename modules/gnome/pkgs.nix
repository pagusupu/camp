{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib) mkEnableOption mkMerge mkIf;
in {
  options.cute.gnome = {
    enable = mkEnableOption "";
    packages = mkEnableOption "";
  };
  config = let
    inherit (config.cute.gnome) enable packages;
  in
    mkMerge [
      (mkIf enable {
        services.xserver = {
          enable = true;
          displayManager.gdm.enable = true;
          desktopManager.gnome.enable = true;
        };
      })
      (mkIf packages {
        environment = {
          systemPackages =
            (builtins.attrValues {
              inherit
                (pkgs)
                blackbox-terminal
                localsend
                mpv
                wl-clipboard
                ;
            })
            ++ (builtins.attrValues {
              inherit
                (pkgs.gnome)
                gnome-tweaks
                ;
            });
          gnome.excludePackages =
            (builtins.attrValues {
              inherit
                (pkgs)
                gnome-console
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
                yelp
                gnome-maps
                gnome-weather
                gnome-contacts
                simple-scan
                ;
            });
        };
        services.xserver.excludePackages = [pkgs.xterm];
      })
    ];
}
