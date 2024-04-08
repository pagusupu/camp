{
  lib,
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = [inputs.nix-gaming.nixosModules.pipewireLowLatency];
  options.cute.desktop = {
    xdg = lib.mkEnableOption "";
    fonts = lib.mkEnableOption "";
    audio = lib.mkEnableOption "";
    greetd = {
      enable = lib.mkEnableOption "";
      command = lib.mkOption {type = lib.types.str;};
    };
  };
  config = let
    inherit (config.cute.desktop) xdg greetd fonts audio;
  in {
    environment.sessionVariables = lib.mkIf xdg {
      XDG_DESKTOP_DIR = "\$HOME/desktop";
      XDG_DOCUMENTS_DIR = "\$HOME/documents";
      XDG_DOWNLOAD_DIR = "\$HOME/downloads";
      XDG_PICTURES_DIR = "\$HOME/pictures";
      XDG_VIDEOS_DIR = "\$HOME/pictures/videos";
    };
    services = {
      greetd = lib.mkIf greetd.enable {
        enable = true;
        settings = rec {
          initial_session = {
            inherit (greetd) command;
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
    fonts = lib.mkIf fonts {
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
        sora = pkgs.callPackage ../../pkgs/sora.nix {};
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
    security.rtkit.enable = lib.mkIf audio true;
    hardware.pulseaudio.enable = lib.mkIf audio false;
  };
}
