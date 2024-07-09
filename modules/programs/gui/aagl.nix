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
    honkers = mkEnableOption "";
    sleepy = mkEnableOption "";
  };
  config = let
    inherit (config.cute.programs.gui.aagl) enable honkers sleepy;
    source = (pkgs.formats.json {}).generate "config.json" {
      game = {
        enhancements = {
          fsr.enabled = false;
          gamemode = true;
          hud = "None";
          gamescope.enabled = false;
        };
        wine = {
          language = "System";
          selected = "wine-9.12-staging-tkg-amd64";
          sync = "FSync";
          shared_libraries = {
            wine = true;
            gstreamer = true;
          };
        };
        voices = ["en-us"];
      };
      launcher = {
        language = "en-us";
        edition = "Global";
        style = "Modern";
        behavior = "Nothing";
      };
      sandbox.enabled = false;
    };
  in
    mkIf enable (mkMerge [
      (mkIf honkers {
        homefile."honkers" = {
          target = ".local/share/honkers-railway-launcher/config.json";
          inherit source;
        };
        programs.honkers-railway-launcher.enable = true;
      })
      (mkIf sleepy {
        homefile."sleepy" = {
          target = ".local/share/sleepy-launcher/config.json";
          inherit source;
        };
        programs.sleepy-launcher.enable = true;
      })
      {
        nix.settings = {
          substituters = ["https://ezkea.cachix.org"];
          trusted-public-keys = ["ezkea.cachix.org-1:ioBmUbJTZIKsHmWWXPe1FSFbeVe+afhfgqgTSNd34eI="];
        };
      }
    ]);
}
