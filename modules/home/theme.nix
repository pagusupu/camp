{
  config,
  inputs,
  ...
}: {
  imports = [inputs.base16.nixosModule];
  scheme = rose-pine/moon.yaml;
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
    in {
      primary = {
        background = base00;
        foreground = base05;
        dim_foreground = base04;
      };
      cursor = {
        text = base02;
        cursor = base07;
      };
      normal = default // {black = base00;};
      bright = default // {black = base03;};
      dim = default // {black = base03;};
    };
  };
}
