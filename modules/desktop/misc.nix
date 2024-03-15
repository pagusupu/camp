{
  lib,
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = [inputs.nix-gaming.nixosModules.pipewireLowLatency];
  options.cute.desktop = {
    greetd = lib.mkEnableOption "";
    audio = lib.mkEnableOption "";
  };
  config = let
    inherit (config.cute.desktop) greetd audio;
  in {
    services = {
      greetd = lib.mkIf greetd {
        enable = true;
        settings = rec {
          initial_session = {
            command = "${pkgs.hyprland}/bin/Hyprland";
            user = "pagu";
          };
          default_session = initial_session;
        };
      };
      pipewire = lib.mkIf audio {
        enable = true;
        jack.enable = true;
        pulse.enable = true;
        wireplumber.enable = true;
        alsa = {
          enable = true;
          support32Bit = true;
        };
        lowLatency = {
          enable = true;
          quantum = 192;
          rate = 192000;
        };
      };
    };
    security.rtkit.enable = lib.mkIf audio true;
  };
}
