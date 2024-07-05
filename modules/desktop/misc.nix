{
  lib,
  config,
  pkgs,
  inputs,
  ...
}: let
  inherit
    (lib)
    mkEnableOption
    mkOption
    types
    concatStringsSep
    mkMerge
    mkIf
    getExe
    ;
in {
  imports = [
    inputs.nix-gaming.nixosModules.pipewireLowLatency
    inputs.home-manager.nixosModules.home-manager
  ];
  options.cute.desktop.misc = {
    audio = mkEnableOption "";
    console = mkEnableOption "";
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
    inherit
      (config.cute.desktop.misc)
      audio
      console
      fonts
      greetd
      home
      ;
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
      (mkIf console {
        boot = {
          initrd.verbose = false;
          kernelParams = ["quiet" "splash"];
        };
        services.kmscon = {
          enable = true;
          hwRender = true;
          fonts = [
            {
              name = "JetBrainsMono Nerd Font";
              package = pkgs.nerdfonts.override {fonts = ["JetBrainsMono"];};
            }
            {
              name = "NerdFontsSymbolsOnly";
              package = pkgs.nerdfonts.override {fonts = ["NerdFontsSymbolsOnly"];};
            }
          ];
        };
      })
      (mkIf fonts {
        fonts = {
          packages = with pkgs; [
            (google-fonts.override {
              fonts = [
                "Lato"
                "Nunito"
              ];
            })
            (nerdfonts.override {
              fonts = [
                "JetBrainsMono"
                "NerdFontsSymbolsOnly"
              ];
            })
            noto-fonts
            noto-fonts-cjk
            noto-fonts-emoji
            noto-fonts-extra
          ];
          fontconfig = {
            enable = true;
            defaultFonts = {
              emoji = ["Noto Color Emoji"];
              monospace = ["JetBrainsMono Nerd Font"];
              sansSerif = ["Nunito"];
              serif = ["Lato"];
            };
            subpixel.rgba = "rgb";
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
            xdg.userDirs = let
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
      })
    ];
}
