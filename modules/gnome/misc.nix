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
  options.cute.gnome.misc = {
    audio = mkEnableOption "";
    fonts = mkEnableOption "";
    home = mkEnableOption "";
    plymouth = mkEnableOption "";
  };
  config = let
    inherit (config.cute.gnome.misc) audio fonts home plymouth;
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
      (mkIf fonts {
        fonts = {
          packages = builtins.attrValues {
            inherit
              (pkgs)
              nerdfonts
              noto-fonts
              noto-fonts-cjk
              noto-fonts-emoji
              noto-fonts-extra
              ;
          };
          fontconfig = {
            enable = true;
            subpixel.rgba = "rgb";
            defaultFonts = {
              emoji = ["Noto Color Emoji"];
              monospace = ["JetBrainsMono Nerd Font"];
              sansSerif = ["Noto Sans"];
              serif = ["Noto Serif"];
            };
          };
        };
      })
      (mkIf home {
        home-manager = {
          useGlobalPkgs = true;
          useUserPackages = true;
          extraSpecialArgs = {inherit inputs;};
          users.pagu.home = {
            username = "pagu";
            homeDirectory = "/home/pagu";
            stateVersion = "23.05";
          };
        };
      })
      (mkIf plymouth {
        boot.plymouth = {
          enable = true;
          font = "${pkgs.nerdfonts}/share/fonts/truetype/NerdFonts/JetBrainsMonoNLNerdFontMono-Regular.ttf";
        };
      })
    ];
}
