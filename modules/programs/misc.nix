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
        environment.systemPackages = builtins.attrValues {
          inherit
            (pkgs)
            localsend
            pwvucontrol
            ueberzugpp
            ;
        };
      })
      (mkIf cli.misc {
        environment = {
          systemPackages = builtins.attrValues {
            inherit
              (pkgs)
              bat
              btop
              dust
              eza
              fzf
              nh
              ouch
              radeontop
              rm-improved
              tealdeer
              speedtest-cli
              wget
              zoxide
              ;
            localsend-rs = pkgs.callPackage ../../misc/pkgs/localsend-rs.nix {};
          };
          sessionVariables.FLAKE = "/home/pagu/flake/"; # nh
        };
        # localsend
        networking.firewall = {
          allowedTCPPorts = [53317];
          allowedUDPPorts = [53317];
        };
      })
    ];
}
