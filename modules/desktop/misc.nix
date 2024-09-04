{
  lib,
  config,
  pkgs,
  inputs,
  ...
}: let
  inherit (lib) mkEnableOption mkMerge mkIf;
in {
  imports = [
    inputs.nix-gaming.nixosModules.pipewireLowLatency
    inputs.home-manager.nixosModules.home-manager
  ];
  options.cute.desktop = {
    misc = {
      audio = mkEnableOption "";
      fonts = mkEnableOption "";
      home = mkEnableOption "";
    };
    mako = mkEnableOption "";
    tofi = mkEnableOption "";
  };
  config = let
    inherit (config.cute.desktop) misc mako tofi;
    inherit (misc) audio fonts home;
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
          lowLatency = mkIf (config.networking.hostName == "rin") {
            enable = true;
            quantum = 48;
            rate = 96000;
          };
        };
        security.rtkit.enable = true;
        hardware.pulseaudio.enable = false;
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
      (mkIf home {
        home-manager = {
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
          extraSpecialArgs = {inherit inputs;};
          useGlobalPkgs = true;
          useUserPackages = true;
        };
      })
      (mkIf mako {
        home-manager.users.pagu = {
          services.mako = with config.colours.base16; {
            enable = true;
            anchor = "bottom-left";
            defaultTimeout = 3;
            maxVisible = 3;
            borderSize = 2;
            borderRadius = 6;
            margin = "6";
            backgroundColor = "#" + A3;
            borderColor = "#" + B6;
            textColor = "#" + A6;
          };
        };
      })
      (mkIf tofi {
        home-manager.users.pagu = {
          programs.tofi = {
            enable = true;
          };
        };
      })
    ];
}
