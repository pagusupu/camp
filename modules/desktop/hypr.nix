{
  config,
  lib,
  _lib,
  pkgs,
  ...
}: let
  inherit (lib) mkEnableOption mkMerge mkIf;
  inherit (_lib) assertHm;
in {
  options.cute.desktop.hypr = {
    lock = mkEnableOption "";
    idle = mkEnableOption "";
  };
  config = let
    inherit (config.cute.desktop.hypr) lock idle;
  in
    mkMerge [
      (mkIf lock {
        assertions = assertHm;
        home-manager.users.pagu.home = {
          file."hyprlock" = {
            target = ".config/hypr/hyprlock.conf";
            text = let
              inherit (config) scheme;
            in ''
              general {
                hide_cursor = true
                disable_loading_bar = true
              }
              background {
                monitor =
                path = screenshot
                blur_size = 10
                blur_passes = 4
              }
              input-field {
                monitor = DP-3
                size = 200, 50
                position = 0, -20
                halign = center
                valign = center
                fade_on_empty = false
                outline_thickness = 3
                outer_color = 0xFF${scheme.base0D}
                inner_color = 0xFF${scheme.base00}
                font_color = 0xFF${scheme.base05}
                check_color = 0xFF${scheme.base0B}
                fail_color = 0xFF${scheme.base08}
                capslock_color = 0xFF${scheme.base0A}
                placeholder_text =
              }
            '';
          };
          packages = [pkgs.hyprlock];
        };
        security.pam.services.hyprlock = {};
      })
      (mkIf idle {
        assertions = _lib.assertHm;
        home-manager.users.pagu.home = {
          file = {
            "hypridle" = {
              target = ".config/hypr/hypridle.conf";
              text = ''
                general {
                  lock_cmd = pidof hyprlock || hyprlock
                }
                listener {
                  timeout = 300
                  on-timeout = loginctl lock-session
                }
              '';
            };
            "inhibit" = {
              target = ".config/wayland-pipewire-idle-inhibit";
              source = (pkgs.formats.toml {}).generate "config.toml" {
                quiet = true;
                node_blacklist = [
                  {name = "Steam";}
                ];
              };
            };
          };
          packages = builtins.attrValues {
            inherit
              (pkgs)
              hypridle
              wayland-pipewire-idle-inhibit
              ;
          };
        };
      })
    ];
}
