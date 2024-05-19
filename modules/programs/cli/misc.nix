{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  inherit (builtins) attrValues;
in {
  options.cute.programs.cli.misc = mkEnableOption "";
  config = mkIf config.cute.programs.cli.misc {
    environment.systemPackages = attrValues {
      inherit
        (pkgs)
        bat
        eza
        flac
        fzf
        nix-output-monitor
        ouch
        radeontop
        rm-improved
        tealdeer
        sox
        wget
        zoxide
        ;
      localsend-rs = pkgs.callPackage ../../../misc/pkgs/localsend-rs.nix {};
    };
    # localsend
    networking.firewall = {
      allowedTCPPorts = [53317];
      allowedUDPPorts = [53317];
    };
  };
}
