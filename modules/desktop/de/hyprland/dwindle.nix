{
  config,
  lib,
  cutelib,
  ...
}:
lib.mkIf (config.cute.desktop.de == "hyprland") {
  assertions = cutelib.assertHm "hyprland-dwindle";
  home-manager.users.pagu = {
    wayland.windowManager.hyprland = let
      inherit (config.cute.desktop.monitors) m1 m2;
    in {
      settings = {
        dwindle = {
          smart_resizing = false;
          force_split = 2;
        };
        windowrulev2 = [
          "workspace 5, class:^(vesktop)$"
          "workspace 5, class:^(discord)$"
          "workspace 5, class:^(feishin)$"
          "float, title:^(Steam - News)$"
          "float, class:^(steam)$,title:^(Special Offers)$"
          "float, title:^(Open Files)$"
          "float, class:^(com.saivert.pwvucontrol)$"
          "float, class:^(thunar)$"
          "float, class:^(localsend_app)$"
          "float, class:^(org.gnome.Calculator)$"
        ];
        workspace = [
          "1, monitor:${m1}, default:true"
          "5, monitor:${m2}, default:true"
        ];
        general.layout = "dwindle";
      };
      extraConfig = let
        inherit (lib) concatMapStringsSep range;
        inherit (builtins) toString;
      in ''
        ${concatMapStringsSep "\n" (n: "workspace=${n}, monitor:${m1}") (map toString (range 1 4))}
        ${concatMapStringsSep "\n" (n: "workspace=${n}, monitor:${m2}") (map toString (range 5 8))}
        ${concatMapStringsSep "\n" (n: "bind=SUPER,${n},workspace,${n}") (map toString (range 1 8))}
        ${concatMapStringsSep "\n" (n: "bind=SUPER:SHIFT,${n},movetoworkspacesilent,${n}") (map toString (range 1 8))}
      '';
    };
  };
}
