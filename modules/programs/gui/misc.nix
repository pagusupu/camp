{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: let
  inherit (lib) mkEnableOption mkMerge mkIf;
in {
  imports = [inputs.aagl.nixosModules.default];
  options.cute.programs.gui = {
    aagl = mkEnableOption "";
    localsend = mkEnableOption "";
    prismlauncher = mkEnableOption "";
  };
  config = let
    inherit (config.cute.programs.gui) aagl localsend prismlauncher;
  in
    mkMerge [
      (mkIf aagl {
        programs = {
          honkers-railway-launcher.enable = true;
          sleepy-launcher.enable = true;
        };
        nix.settings = {
          substituters = ["https://ezkea.cachix.org"];
          trusted-public-keys = ["ezkea.cachix.org-1:ioBmUbJTZIKsHmWWXPe1FSFbeVe+afhfgqgTSNd34eI="];
        };
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
