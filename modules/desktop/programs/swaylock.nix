{
  config,
  lib,
  pkgs,
  ...
}: {
  options.cute.desktop.programs.swaylock = lib.mkEnableOption "";
  config = lib.mkIf config.cute.desktop.programs.swaylock {
    home-manager.users.pagu = {
      programs.swaylock = {
        enable = true;
        package = pkgs.swaylock-effects;
        settings = let
          inherit (config.cute) colours;
        in {
          image = "~/flake/modules/desktop/images/lockbg.png";
          clock = true;
          indicator = true;
          timestr = "%I:%M %p";
          datestr = "";
          font = "MonaspiceNE Nerd Font";
          font-size = 18;
          line-uses-inside = true;

          color = "#${colours.base}";
          bs-hl-color = "#${colours.love}";
          key-hl-color = "#${colours.iris}";
          separator-color = "#${colours.muted}";

          inside-color = "#${colours.surface}";
          inside-ver-color = "#${colours.surface}";
          inside-clear-color = "#${colours.surface}";
          inside-wrong-color = "#${colours.surface}";
          inside-caps-lock-color = "#${colours.surface}";

          ring-color = "#${colours.muted}";
          ring-ver-color = "#${colours.muted}";
          ring-wrong-color = "#${colours.muted}";
          ring-clear-color = "#${colours.muted}";
          ring-caps-lock-color = "#${colours.muted}";

          text-color = "#${colours.text}";
          text-ver-color = "#${colours.pine}";
          text-wrong-color = "#${colours.love}";
          text-clear-color = "#${colours.rose}";
          text-caps-lock-color = "#${colours.love}";
        };
      };
    };
    security.pam.services.swaylock = {};
  };
}
