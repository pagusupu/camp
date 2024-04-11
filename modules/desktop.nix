{
  lib,
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = [inputs.nix-gaming.nixosModules.pipewireLowLatency];
  options.cute.desktop = let
    inherit (lib) mkEnableOption mkOption types;
  in {
    audio = mkEnableOption "";
    fonts = mkEnableOption "";
    greetd = {
      enable = mkEnableOption "";
      command = mkOption {type = types.str;};
    };
  };
  config = let
    inherit (config.cute.desktop) audio fonts greetd;
    inherit (lib) mkMerge mkIf;
  in
    mkMerge [
      (mkIf audio {
        services.pipewire = {
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
        security.rtkit.enable = true;
        hardware.pulseaudio.enable = false;
      })
      (mkIf fonts {
        fonts = {
          packages = builtins.attrValues {
            inherit
              (pkgs)
              lato
              nerdfonts
              noto-fonts
              noto-fonts-cjk
              noto-fonts-emoji
              noto-fonts-extra
              ;
            sora = pkgs.callPackage ../misc/pkgs/sora.nix {};
          };
          fontconfig = {
            enable = true;
            subpixel.rgba = "rgb";
            defaultFonts = {
              emoji = ["Noto Color Emoji"];
              monospace = ["MonaspiceNe Nerd Font"];
              sansSerif = ["Sora"];
              serif = ["Lato"];
            };
          };
        };
      })
      (mkIf greetd.enable {
        services.greetd = {
          enable = true;
          settings = rec {
            initial_session = {
              inherit (greetd) command;
              user = "pagu";
            };
            default_session = initial_session;
          };
        };
      })
    ];
}
