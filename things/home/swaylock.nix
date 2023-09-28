{
  pkgs,
  lib,
  config,
  mcolours,
  ...
}: {
  imports = [../misc/user/colours.nix];
  options.cute.programs.swaylock = {
    enable = lib.mkEnableOption "";
  };
  config = lib.mkIf config.cute.programs.swaylock.enable {
    programs.swaylock = {
      enable = true;
      package = pkgs.swaylock-effects;
      settings = {
        clock = true;
        indicator = true;
        font = "nunito";
        font-size = 30;
        indicator-radius = 100;
        image = "~/Nix/things/images/bg1.png";

        inside-color = "${mcolours.primary.bg}";
        inside-clear-color = "${mcolours.primary.bg}";
        inside-caps-lock-color = "${mcolours.primary.bg}";
        inside-ver-color = "${mcolours.primary.bg}";
        inside-wrong-color = "${mcolours.primary.bg}";

        ring-color = "000000";
        ring-clear-color = "${mcolours.normal.yellow}";
        ring-caps-lock-color = "${mcolours.normal.red}";
        ring-ver-color = "${mcolours.primary.main}";
        ring-wrong-color = "${mcolours.normal.red}";

        text-color = "${mcolours.primary.main}";
        text-clear-color = "${mcolours.normal.yellow}";
        text-caps-lock-color = "${mcolours.normal.red}";
        text-ver-color = "${mcolours.primary.main}";
        text-wrong-color = "${mcolours.normal.red}";

        line-uses-inside = true;
        key-hl-color = "${mcolours.primary.main}";
      };
    };
  };
}
