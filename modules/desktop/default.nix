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
    home-manager.users.pagu = lib.mkIf misc {
      home.packages = with pkgs; [
        element-desktop
        localsend
        pwvucontrol
        sublime-music
        ueberzugpp
        vesktop
        xfce.thunar
      ];
    };
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
    security.rtkit.enable = lib.mkIf audio true;
  };
}
