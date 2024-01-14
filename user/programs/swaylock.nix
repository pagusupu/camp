{
  config,
  lib,
  pkgs,
  ...
}: {
  options.hm.programs.swaylock.enable = lib.mkEnableOption "";
  config = let
    inherit (config.cute) colours;
  in
    lib.mkIf config.hm.programs.swaylock.enable {
      programs.swaylock = {
        enable = true;
        package = pkgs.swaylock-effects;
        settings = {
	  image = "~/flake/user/images/lockbg.png";
          clock = true;
          indicator = true;
	  timestr = "%I:%M %p";
	  datestr = "";
	  font = "MonaspiceNE Nerd Font";
	  font-size = 18;
	  line-uses-inside = true;
	  color = "#${colours.base}";
	  separator-color = "#${colours.muted}";
	  inside-color = "#${colours.surface}";
	  inside-ver-color = "#${colours.surface}";
	  inside-clear-color = "#${colours.surface}";
	  inside-wrong-color = "#${colours.surface}";
	  bs-hl-color = "#${colours.love}";
	  key-hl-color = "#${colours.iris}";
	  ring-color = "#${colours.muted}";
	  ring-caps-lock-color = "#${colours.muted}";
	  ring-ver-color = "#${colours.muted}";
	  ring-wrong-color = "#${colours.muted}";
	  ring-clear-color = "#${colours.muted}";
	  text-color = "#${colours.text}";
	  text-clear-color = "#${colours.rose}";
	  text-ver-color = "#${colours.pine}";
	  text-wrong-color = "#${colours.love}";
	  text-caps-lock-color = "#${colours.love}";
        };
      };
    };
}
