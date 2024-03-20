{
  config,
  lib,
  ...
}: {
  options.cute.home.waybar = lib.mkEnableOption "";
  config = lib.mkIf config.cute.home.waybar {
    home-manager.users.pagu = {
      programs.waybar = {
        enable = true;
        settings = let
          time = {format = "{: %I \n %M \n %p}";};
        in {
          leftbar = {
            layer = "top";
            position = "left";
            width = 32;
            output = ["DP-3"];
            modules-center = ["clock"];
            clock = time;
          };
        };
        style = ''
        '';
      };
    };
  };
}
