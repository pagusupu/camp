{
  config,
  lib,
  pkgs,
  rose-pine,
  ...
}: {
  options.cute.home = {
    gtk = lib.mkEnableOption "";
    mako = lib.mkEnableOption "";
    wofi = lib.mkEnableOption "";
  };
  config = let
    inherit (config.cute.home) enable gtk mako wofi;
    inherit (rose-pine) moon;
  in {
    home-manager.users.pagu = lib.mkIf enable {
      gtk = lib.mkIf gtk {
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
      qt = lib.mkIf gtk {
        enable = true;
        platformTheme = "gtk";
      };
      home = lib.mkIf gtk {
        packages = [pkgs.dconf];
        pointerCursor = {
          package = pkgs.rose-pine-cursor;
          name = lib.mkDefault "BreezeX-RosePineDawn-Linux";
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
        style = ''
          window {
            background-color: #${moon.base};
            color: #${moon.text};
            border: 2px solid #${moon.iris};
            border-radius: 6px;
            font-family: 'MonaspiceNe Nerd Font';
            font-size: 16px;
          }
          #input {
            background-color: #${moon.surface};
            color: #${moon.iris};
            border: 2px solid #${moon.iris};
            border-radius: 6px;
          }
        '';
      };
      services = {
        mako = lib.mkIf mako {
          enable = true;
          anchor = "bottom-left";
          defaultTimeout = 3;
          maxVisible = 3;
          borderSize = 2;
          borderRadius = 6;
          margin = "14";
          backgroundColor = "#" + moon.overlay;
          borderColor = "#" + moon.iris;
          textColor = "#" + moon.text;
          extraConfig = ''
            [mode=do-not-disturb]
            invisible=1
          '';
        };
      };
    };
  };
}
