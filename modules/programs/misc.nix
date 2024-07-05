{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib) mkEnableOption mkMerge mkIf;
in {
  options.cute.programs = {
    cli.misc = mkEnableOption "";
    gui.misc = mkEnableOption "";
  };
  config = let
    inherit (config.cute.programs) gui cli;
  in
    mkMerge [
      (mkIf gui.misc {
        environment.systemPackages = with pkgs; [
          heroic
          imv
          mpv
          pwvucontrol
          xivlauncher
	  xfce.thunar
        ];
      })
      (mkIf cli.misc {
        environment.systemPackages = with pkgs; [
          ouch
          radeontop
          wget
        ];
      })
    ];
}
