{
  lib,
  config,
  pkgs,
  inputs,
  colours,
  ...
}: let
  inherit (lib) mkEnableOption mkOption types concatStringsSep mkMerge mkIf getExe;
in {
  imports = [
    inputs.nix-gaming.nixosModules.pipewireLowLatency
    inputs.home-manager.nixosModules.home-manager
  ];
  options.cute.desktop.misc = {
    audio = mkEnableOption "";
    boot = mkEnableOption "";
    fonts = mkEnableOption "";
    greetd = {
      enable = mkEnableOption "";
      sessionDirs = mkOption {
        type = types.listOf types.str;
        apply = concatStringsSep ":";
        default = [];
      };
    };
    home = mkEnableOption "";
  };
  config = let
    inherit (config.cute.desktop.misc) audio boot fonts greetd home;
  in
    mkMerge [
      (mkIf audio {
        services.pipewire = {
          enable = true;
          jack.enable = true;
          pulse.enable = true;
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
            sora = pkgs.callPackage ../../misc/pkgs/sora.nix {};
          };
          fontconfig = {
            enable = true;
            subpixel.rgba = "rgb";
            defaultFonts = {
              emoji = ["Noto Color Emoji"];
              monospace = ["JetBrainsMono Nerd Font"];
              sansSerif = ["Sora"];
              serif = ["Lato"];
            };
          };
        };
      })
      (mkIf greetd.enable {
        services.greetd = {
          enable = true;
          settings.default_session = {
            command = "${getExe pkgs.greetd.tuigreet} --sessions ${greetd.sessionDirs} --asterisks --remember-session -r -t";
            user = "greeter";
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
            xdg = {
              enable = true;
              userDirs = let
                p = "/home/pagu/";
              in {
                enable = true;
                desktop = p + ".local/misc/desktop";
                documents = p + "documents";
                download = p + "downloads";
                pictures = p + "pictures";
                videos = p + "pictures/videos";
              };
            };
          };
        };
      })
    ];
}
