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
    misc = mkEnableOption "";
    aagl = mkEnableOption "";
  };
  config = let
    inherit (config.cute.programs.gui) misc aagl;
  in
    mkMerge [
      (mkIf misc {
        environment.systemPackages = with pkgs;
          [
            audacity
            feishin
            heroic
            imv
            lrcget
            mpv
            pwvucontrol
            vesktop
          ]
          ++ [inputs.nix-gaming.packages.${pkgs.system}.osu-lazer-bin];
        programs.localsend = {
          enable = true;
          openFirewall = true;
        };
      })
      (mkIf aagl {
        homefile."honkers" = {
          target = ".local/share/honkers-railway-launcher/config.json";
          source = (pkgs.formats.json {}).generate "config.json" {
            game = {
              enhancements = {
                fsr.enabled = false;
                gamemode = true;
              };
              wine.selected = "wine-9.12-staging-tkg-amd64";
            };
            launcher.behavior = "Nothing";
          };
        };
        nix.settings = {
          substituters = ["https://ezkea.cachix.org"];
          trusted-public-keys = ["ezkea.cachix.org-1:ioBmUbJTZIKsHmWWXPe1FSFbeVe+afhfgqgTSNd34eI="];
        };
        programs.honkers-railway-launcher.enable = true;
      })
    ];
}
