{
  lib,
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = [inputs.nix-gaming.nixosModules.pipewireLowLatency];
  options.cute.desktop = {
    misc = lib.mkEnableOption "";
    greetd = lib.mkEnableOption "";
    audio = lib.mkEnableOption "";
  };
  config = let
    inherit (config.cute.desktop) misc greetd audio;
  in {
    home-manager = lib.mkIf misc {
      users.pagu.home.packages = with pkgs; [
        imv
        localsend
        pwvucontrol
        ueberzugpp
        xfce.thunar
        yazi
      ];
    };
    # localsend
    networking.firewall = lib.mkIf misc {
      allowedTCPPorts = [53317];
      allowedUDPPorts = [53317];
    };
    services = {
      greetd = lib.mkIf greetd {
        enable = true;
        settings = {
          default_session = {
            command = "${pkgs.greetd.tuigreet}/bin/tuigreet --asterisks --remember --cmd Hyprland";
            user = "pagu";
          };
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
    hardware.pulseaudio.enable = lib.mkIf audio false;
    security.rtkit.enable = lib.mkIf audio true;
  };
}
