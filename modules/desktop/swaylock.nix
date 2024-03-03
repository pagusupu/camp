{
  config,
  lib,
  pkgs,
  ...
}: {
  options.cute.desktop.swaylock = lib.mkEnableOption "";
  config = lib.mkIf config.cute.desktop.swaylock {
    home-manager.users.pagu = {
      programs.swaylock = {
        enable = true;
        package = pkgs.swaylock-effects;
        settings = let
          inherit (config.cute) colours;
        in {
          clock = true;
          indicator = true;
          line-uses-inside = true;
          font-size = 18;
          datestr = "";
          timestr = "%I:%M %p";
          font = "MonaspiceNE Nerd Font";
          image = "~/flake/modules/home/images/lockbg.png";

          color = "#" + colours.base;
          bs-hl-color = "#" + colours.love;
          key-hl-color = "#" + colours.iris;
          separator-color = "#" + colours.muted;

          inside-color = "#" + colours.surface;
          inside-ver-color = "#" + colours.surface;
          inside-wrong-color = "#" + colours.surface;
          inside-clear-color = "#" + colours.surface;
          inside-caps-lock-color = "#" + colours.surface;

          ring-color = "#" + colours.muted;
          ring-ver-color = "#" + colours.muted;
          ring-wrong-color = "#" + colours.muted;
          ring-clear-color = "#" + colours.muted;
          ring-caps-lock-color = "#" + colours.muted;

          text-color = "#" + colours.text;
          text-ver-color = "#" + colours.pine;
          text-wrong-color = "#" + colours.love;
          text-clear-color = "#" + colours.rose;
          text-caps-lock-color = "#" + colours.love;
        };
      };
    };
    security.pam.services.swaylock = {};
  };
}
