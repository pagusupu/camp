{
  config,
  lib,
  cutelib,
  inputs,
  pkgs,
  ...
}: {
  imports = [inputs.aagl.nixosModules.default];
  options.cute.programs.aagl = cutelib.mkEnable;
  config = lib.mkIf config.cute.programs.aagl {
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
    environment.systemPackages = let
      wt = pkgs.writeShellScriptBin "warp" ''
        rm ~/downloads/data_2
        cp ~/.local/share/honkers-railway-launcher/HSR/StarRail_Data/webCaches/2.28.0.0/Cache/Cache_Data/data_2 ~/downloads
      '';
    in [wt];
    nix.settings = {
      substituters = ["https://ezkea.cachix.org"];
      trusted-public-keys = ["ezkea.cachix.org-1:ioBmUbJTZIKsHmWWXPe1FSFbeVe+afhfgqgTSNd34eI="];
    };
    programs.honkers-railway-launcher.enable = true;
  };
}
