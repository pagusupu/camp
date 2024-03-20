{
  config,
  lib,
  inputs,
  ...
}: {
  imports = [inputs.base16.nixosModule];
  options.cute.home.base16 = lib.mkEnableOption "";
  config = let
    inherit (config.cute.desktop) alacritty;
    inherit (config.cute.home) hyprland;
    inherit (config.cute.common.system) boot;
  in
    lib.mkIf config.cute.home.base16 {
      scheme = lib.mkDefault rose-pine/dawn.yaml;
      home-manager.users.pagu = {
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
      console.colors = with config.scheme;
        lib.mkIf boot [
          base00
          base08
          base0C
          base09
          base0B
          base0D
          base0A
          base06
          base02
          base08
          base0C
          base09
          base0B
          base0D
          base0A
          base06
        ];
    };
}
