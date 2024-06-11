{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib) mkEnableOption mkMerge mkIf;
  inherit (builtins) attrValues;
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
        environment.systemPackages = attrValues {
          inherit
            (pkgs)
            heroic
            imv
            localsend
            mpv
            prismlauncher
            pwvucontrol
            ;
        };
      })
      (mkIf cli.misc {
        environment.systemPackages = attrValues {
          inherit
            (pkgs)
            bat
            eza
            fzf
            nix-output-monitor
            ouch
            radeontop
            rm-improved
            tealdeer
            wget
            zoxide
            ;
          localsend-rs = pkgs.callPackage ../../misc/pkgs/localsend-rs.nix {};
        };
        # localsend
        networking.firewall = {
          allowedTCPPorts = [53317];
          allowedUDPPorts = [53317];
        };
      })
    ];
}
