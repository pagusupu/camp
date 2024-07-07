{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib) mkEnableOption mkMerge mkIf;
in {
  options.cute.programs.gui = {
    misc = mkEnableOption "";
    localsend = mkEnableOption "";
    prismlauncher = mkEnableOption "";
  };
  config = let
    inherit (config.cute.programs) gui;
    inherit (gui) localsend prismlauncher;
  in
    mkMerge [
      (mkIf gui.misc {
        environment.systemPackages = with pkgs; [
          heroic
          imv
          mpv
          pwvucontrol
          xivlauncher
        ];
      })
      (mkIf localsend {
        networking.firewall = {
          allowedTCPPorts = [53317];
          allowedUDPPorts = [53317];
        };
        environment.systemPackages = [pkgs.localsend];
      })
      (mkIf prismlauncher {
        environment = {
          etc = {
            "jdks/21".source = pkgs.openjdk21 + /bin;
            "jdks/17".source = pkgs.openjdk17 + /bin;
            "jdks/8".source = pkgs.openjdk8 + /bin;
          };
          systemPackages = [pkgs.prismlauncher];
        };
      })
    ];
}
