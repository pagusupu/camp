{
  lib,
  config,
  pkgs,
  inputs,
  colours,
  ...
}: let
  inherit (lib) mkEnableOption mkOption types mkMerge mkIf;
in {
  imports = [
    inputs.nix-gaming.nixosModules.pipewireLowLatency
    inputs.home-manager.nixosModules.home-manager
  ];
  options.cute.desktop = {
    audio = mkEnableOption "";
    boot = mkEnableOption "";
    fonts = mkEnableOption "";
    greetd = {
      enable = mkEnableOption "";
      command = mkOption {type = types.str;};
    };
    home = mkEnableOption "";
  };
  config = let
    inherit (config.cute.desktop) audio boot fonts greetd home;
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
            quantum = 48;
            rate = 192000;
          };
        };
        security.rtkit.enable = true;
        hardware.pulseaudio.enable = false;
      })
      (mkIf boot {
        boot = {
          enableContainers = false;
          initrd.verbose = false;
          kernelParams = ["quiet" "splash"];
        };
        console = {
          font = "${pkgs.terminus_font}/share/consolefonts/ter-116n.psf.gz";
          colors = let
            inherit (colours) dark;
          in [
            "000000"
            dark.love
            dark.foam
            dark.gold
            dark.pine
            dark.iris
            dark.rose
            dark.text
            dark.overlay
            dark.love
            dark.foam
            dark.gold
            dark.pine
            dark.iris
            dark.rose
            dark.text
          ];
        };
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
      (mkIf home {
        home-manager = {
          useGlobalPkgs = true;
          useUserPackages = true;
          extraSpecialArgs = {inherit inputs;};
          users.pagu = {
            home = {
              username = "pagu";
              homeDirectory = "/home/pagu";
              stateVersion = "23.05";
            };
          };
        };
      })
    ];
}
