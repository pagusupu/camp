{
  config,
  lib,
  pkgs,
  ...
}: {
  options.hm.programs.swaylock.enable = lib.mkEnableOption "";
  config = lib.mkIf config.hm.programs.swaylock.enable {
    programs.swaylock = {
      enable = true;
      package = pkgs.swaylock-effects;
      settings = {
	color = "#${config.cute.colours.base}";
        clock = true;
        indicator = true;
      };
    };
  };
}
