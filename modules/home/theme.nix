{
  config,
  lib,
  inputs,
  pkgs,
  rose-pine,
  ...
}: {
  imports = [inputs.base16.nixosModule];
  options.cute.home = {
    base16 = lib.mkEnableOption "";
    gtk = lib.mkEnableOption "";
  };
  config = let
    inherit (config.cute.desktop) alacritty;
    inherit (config.cute.home) gtk hyprland;
    inherit (config.cute.common) nixvim;
  in
    lib.mkIf config.cute.home.base16 {
      scheme = lib.mkDefault rose-pine/dawn.yaml;
      home-manager.users.pagu = {
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
        programs.alacritty.settings.colors = with config.scheme.withHashtag; let
          default = {
            white = base06;
            blue = base0C;
            red = base08;
            green = base0B;
            yellow = base09;
            magenta = base0D;
            cyan = base0A;
          };
        in
          lib.mkIf alacritty {
            primary = {
              background = base00;
              foreground = base05;
            };
            cursor = {
              text = base02;
              cursor = base07;
            };
            normal = default // {black = base00;};
            bright = default // {black = base03;};
            dim = default // {black = base03;};
          };
        wayland.windowManager.hyprland.settings.general = with config.scheme;
          lib.mkIf hyprland {
            "col.active_border" = "0xFF" + base0B;
            "col.inactive_border" = "0xFF" + base00;
          };
      };
      console.colors = with rose-pine.moon; [
        "000000"
        love
        foam
        gold
        pine
        iris
        rose
        text
        overlay
        love
        foam
        gold
        pine
        iris
        rose
        text
      ];
      specialisation.dark.configuration = {
        home-manager.users.pagu = lib.mkIf gtk {
          gtk = {
            theme.name = "rose-pine-moon";
            iconTheme.name = "rose-pine-moon";
          };
          home.pointerCursor.name = "BreezeX-RosePineDawn-Linux";
        };
        scheme = rose-pine/moon.yaml;
        programs.nixvim.colorschemes.rose-pine.style = lib.mkIf nixvim "moon";
      };
    };
}
