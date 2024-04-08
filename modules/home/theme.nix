{
  config,
  lib,
  inputs,
  pkgs,
  colours,
  ...
}: {
  imports = [inputs.base16.nixosModule];
  options.cute.home = {
    base16 = lib.mkEnableOption "";
    gtk = lib.mkEnableOption "";
  };
  config = let
    inherit (config.cute.home) gtk hyprland;
  in
    lib.mkIf config.cute.home.base16 {
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
        wayland.windowManager.hyprland.settings.general = let
          inherit (config) scheme;
        in
          lib.mkIf hyprland {
            "col.active_border" = "0xFF" + scheme.base0B;
            "col.inactive_border" = "0xFF" + scheme.base00;
          };
      };
      console.colors = let
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
      specialisation.dark.configuration = {
        home-manager.users.pagu = lib.mkIf gtk {
          gtk = {
            theme.name = "rose-pine-moon";
            iconTheme.name = "rose-pine-moon";
          };
          home.pointerCursor.name = "BreezeX-RosePineDawn-Linux";
        };
      };
    };
}
