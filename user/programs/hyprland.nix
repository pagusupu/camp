{
  config,
  lib,
  ...
}: {
  options.hm.programs.hyprland.enable = lib.mkEnableOption "";
  config = lib.mkIf config.hm.programs.hyprland.enable {
    wayland.windowManager.hyprland = {
      enable = true;
      settings = {
        "$mod" = "SUPER";
        bind =
          [
            "$mod, Enter, exec, alacritty"
          ]


          # keep at end
          ++ (
            builtins.concatLists (builtins.genList (
                x: let
                  ws = let
                    c = (x + 1) / 9;
                  in
                    builtins.toString (x + 1 - (c * 9));
                in [
                  "$mod, ${ws}, workspace, ${toString (x + 1)}"
                  "$mod SHIFT, ${ws}, movetoworkspace, ${toString (x + 1)}"
                ]
              )
              9)
          );
      };
    };
  };
}
