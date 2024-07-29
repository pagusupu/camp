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
  options.cute.programs.gui.aagl = {
    enable = mkEnableOption "";
    anime = mkEnableOption "";
    honkers = mkEnableOption "";
  };
  config = let
    inherit (config.cute.programs.gui.aagl) enable anime honkers;
    fsr.enabled = false;
    gamemode = true;
    gamescope.enabled = false;
    launcher = {
      behavior = "Nothing";
      language = "en-us";
    };
  in
    mkIf enable (mkMerge [
      (mkIf anime {
        homefile."anime" = {
          target = ".local/share/anime-game-launcher/config.json";
          source = (pkgs.formats.json {}).generate "config.json" {
            game = {
              enhancements = {
                fps_unlocker = {
                  enabled = true;
                  config.fps = 165;
                };
                inherit fsr gamemode gamescope;
              };
              wine = {
                borderless = true;
                selected = "lutris-GE-Proton8-26-x86_64";
              };
            };
            inherit launcher;
          };
        };
        programs.anime-game-launcher.enable = true;
      })
      (mkIf honkers {
        homefile."honkers" = {
          target = ".local/share/honkers-railway-launcher/config.json";
          source = (pkgs.formats.json {}).generate "config.json" {
            game = {
              enhancements = {inherit fsr gamemode gamescope;};
              wine.selected = "wine-9.13-staging-tkg-amd64";
            };
            inherit launcher;
          };
        };
        programs.honkers-railway-launcher.enable = true;
      })
      {
        nix.settings = {
          substituters = ["https://ezkea.cachix.org"];
          trusted-public-keys = ["ezkea.cachix.org-1:ioBmUbJTZIKsHmWWXPe1FSFbeVe+afhfgqgTSNd34eI="];
        };
      }
    ]);
}
