{
  config,
  lib,
  pkgs,
  ...
}: {
  options.cute.programs.gui = {
    localsend = lib.mkEnableOption "";
  };
  config = let
    inherit (config.cute.programs.gui) localsend;
  in
    lib.mkMerge [
      (lib.mkIf localsend {
        environment.systemPackages = [pkgs.localsend];
        networking.firewall = {
          allowedTCPPorts = [53317];
          allowedUDPPorts = [53317];
        };
      })
    ];
}
