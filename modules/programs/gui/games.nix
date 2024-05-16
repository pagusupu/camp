{
  config,
  lib,
  inputs,
  pkgs,
  ...
}: let
  inherit (lib) mkEnableOption mkMerge mkIf;
in {
  imports = [inputs.aagl.nixosModules.default];
  options.cute.programs.gui.games = {
    aagl = mkEnableOption "";
    misc = mkEnableOption "";
    osu = mkEnableOption "";
  };
  config = let
    inherit (config.cute.programs.gui.games) aagl misc osu;
  in
    mkMerge [
      (mkIf aagl {
        nix.settings = {
          substituters = ["https://ezkea.cachix.org"];
          trusted-public-keys = ["ezkea.cachix.org-1:ioBmUbJTZIKsHmWWXPe1FSFbeVe+afhfgqgTSNd34eI="];
        };
        programs.honkers-railway-launcher.enable = true;
      })
      (mkIf misc {
        environment.systemPackages = builtins.attrValues {
          inherit
            (pkgs)
            heroic
            prismlauncher
            r2modman
            ;
        };
        hardware.xone.enable = true;
      })
      (mkIf osu {
        nix.settings = {
          substituters = ["https://nix-gaming.cachix.org"];
          trusted-public-keys = ["nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4="];
        };
        environment.systemPackages = [inputs.nix-gaming.packages.${pkgs.system}.osu-lazer-bin];
      })
    ];
}
