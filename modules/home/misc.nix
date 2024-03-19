{
  config,
  lib,
  pkgs,
  ...
}: {
  options.cute.home = {
    gtk = lib.mkEnableOption "";
    mako = lib.mkEnableOption "";
    wofi = lib.mkEnableOption "";
  };
  config = let
    inherit (config.cute.home) enable gtk mako wofi;
  in {
    home-manager.users.pagu = lib.mkIf enable {
      gtk = lib.mkIf gtk {
        enable = true;
        theme = {
          package = pkgs.rose-pine-gtk-theme;
          name = lib.mkDefault "rose-pine-dawn";
        };
        iconTheme = {
          package = pkgs.rose-pine-icon-theme;
          name = lib.mkDefault "rose-pine-dawn";
        };
      };
      qt = lib.mkIf gtk {
        enable = true;
        platformTheme = "gtk";
      };
      home = lib.mkIf gtk {
        packages = [pkgs.dconf];
        pointerCursor = {
          package = pkgs.rose-pine-cursor;
          name = lib.mkDefault "BreezeX-RosePine-Linux";
          size = 24;
          gtk.enable = true;
          x11.enable = true;
        };
      };
      programs.wofi = lib.mkIf wofi {
        enable = true;
        settings = {
          hide_scroll = true;
          insensitive = true;
          width = "10%";
          prompt = "";
          lines = 7;
        };
      };
      services = with config.scheme; {
        mako = lib.mkIf mako {
          enable = true;
          anchor = "bottom-left";
          defaultTimeout = 3;
          maxVisible = 3;
          borderSize = 2;
          borderRadius = 6;
          margin = "14";
          backgroundColor = "#" + base00;
          borderColor = "#" + base0D;
          textColor = "#" + base05;
          extraConfig = ''
            [mode=do-not-disturb]
            invisible=1
          '';
        };
      };
    };
  };
}
