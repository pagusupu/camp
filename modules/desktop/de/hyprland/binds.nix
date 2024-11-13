{
  config,
  lib,
  cutelib,
  pkgs,
  ...
}:
lib.mkIf (config.cute.desktop.de == "hyprland") {
  assertions = cutelib.assertHm "hyprland-binds";
  home-manager.users.pagu = {
    wayland.windowManager.hyprland = let
      m = "SUPER,";
      s = "SUPER:SHIFT,";
    in
      lib.mkMerge [
        {
          settings = {
            bindm = [
              "${m} mouse:272, movewindow"
              "${m} mouse:273, resizewindow"
            ];
            bind = [
              "${m} RETURN, exec, alacritty"
              "${m} TAB, exec, wofi"
              "${s} TAB, overview:toggle"
              "${m} L, exec, gtklock"

              "${m} Q, killactive"
              "${m} F, fullscreen"
              "${m} SPACE, togglefloating"
              "${s} M, exit"

              "${m} left, movefocus, l"
              "${s} left, movewindow, l"
              "${m} right, movefocus, r"
              "${s} right, movewindow, r"
              "${m} up, movefocus, u"
              "${s} up, movewindow, u"
              "${m} down, movefocus, d"
              "${s} down, movewindow, d"
            ];
          };
        }
        {
          settings.bind = let
            p = "~/pictures/screenshots/";
            date = "$(date '+%H:%M:%S').png";
            grimblast = "BACKSPACE, exec, grimblast --notify --freeze";
            grim = ''P, exec, grim -g "$(slurp)" -t ppm -'';
            satty = "satty --filename - ";
          in [
            "${m} ${grimblast} copy area"
            "${s} ${grimblast} save area ${p}${date}"
            ''${m} ${grim} | ${satty} --copy-command wl-copy''
            ''${s} ${grim} | ${satty} --output-filename ${p}satty-${date}''
          ];
        }
      ];
    home.packages = with pkgs; [
      grim
      grimblast
      satty
      slurp
    ];
  };
}
