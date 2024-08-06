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
    p = ".local/share";
    c = "config.json";
    json = (pkgs.formats.json {}).generate "${c}";
    fsr.enabled = false;
    gamemode = true;
    launcher.behavior = "Nothing";
  in
    mkIf enable (mkMerge [
      (mkIf anime {
        homefile."${p}/anime-game-launcher/${c}".source = json {
          game = {
            enhancements = {
              fps_unlocker = {
                enabled = true;
                config.fps = 165;
              };
              inherit fsr gamemode;
            };
            wine = {
              borderless = true;
              selected = "lutris-GE-Proton8-26-x86_64";
            };
          };
          inherit launcher;
        };
        programs.anime-game-launcher.enable = true;
      })
      (mkIf honkers {
        homefile."${p}/honkers-railway-launcher/${c}".source = json {
          game = {
            enhancements = {inherit fsr gamemode;};
            wine.selected = "wine-9.12-staging-tkg-amd64";
          };
          inherit launcher;
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
