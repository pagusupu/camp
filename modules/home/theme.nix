{
  config,
  lib,
  pkgs,
  ...
}: {
  options.cute.home = {
    fonts = lib.mkEnableOption "";
    gtk = lib.mkEnableOption "";
  };
  config = let
    inherit (config.cute.home) fonts gtk;
  in {
    home-manager.users.pagu = lib.mkIf gtk {
      gtk = {
        enable = true;
        theme = {
          package = pkgs.rose-pine-gtk-theme;
          name = lib.mkDefault "rose-pine-moon";
        };
        iconTheme = {
          package = pkgs.rose-pine-icon-theme;
          name = lib.mkDefault "rose-pine-moon";
        };
      };
      qt = {
        enable = true;
        platformTheme = "gtk";
      };
      home = {
        packages = [pkgs.dconf];
        pointerCursor = {
          package = pkgs.rose-pine-cursor;
          name = lib.mkDefault "BreezeX-RosePineDawn-Linux";
          size = 24;
          gtk.enable = true;
          x11.enable = true;
        };
      };
    };
    fonts = lib.mkIf fonts {
      packages = with pkgs; [
        lato
        nerdfonts
        noto-fonts
        noto-fonts-cjk
        noto-fonts-emoji
        noto-fonts-extra
        (pkgs.callPackage ../../pkgs/sora.nix {})
      ];
      fontconfig = {
        enable = true;
        antialias = true;
        hinting.enable = true;
        hinting.autohint = true;
        subpixel.rgba = "rgb";
        defaultFonts = {
          emoji = ["Noto Color Emoji"];
          monospace = ["MonaspiceNe Nerd Font"];
          sansSerif = ["Sora"];
          serif = ["Lato"];
        };
      };
    };
  };
}
