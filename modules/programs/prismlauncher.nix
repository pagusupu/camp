{
  config,
  lib,
  cutelib,
  pkgs,
  ...
}: {
  options.cute.programs.prismlauncher = cutelib.mkEnable;
  config = lib.mkIf config.cute.programs.prismlauncher {
    environment = {
      etc = {
        "jdks/21".source = lib.getBin pkgs.openjdk21;
        "jdks/17".source = lib.getBin pkgs.openjdk17;
        "jdks/8".source = lib.getBin pkgs.openjdk8;
      };
      systemPackages = [pkgs.prismlauncher];
    };
    homefile = {
      "prism-json" = {
        target = ".local/share/PrismLauncher/themes/rose-pine/theme.json";
        source = (pkgs.formats.json {}).generate "theme.json" {
          colors = with config.wh.colours; {
            AlternateBase = surface;
            Base = base;
            BrightText = text;
            Button = overlay;
            ButtonText = text;
            Highlight = love;
            HighlightedText = surface;
            Link = iris;
            Text = text;
            ToolTipBase = iris;
            ToolTipText = iris;
            Window = surface;
            WindowText = text;
            fadeAmount = 0;
          };
          name = "Rose-Pine";
          qssFilePath = "themeStyle.css";
          widgets = "Fusion";
        };
      };
      "prism-css" = {
        target = ".local/share/PrismLauncher/themes/rose-pine/themeStyle.css";
        text = with config.wh.colours;
        # css
          ''
            QToolTip {
                color: ${text};
                background-color: ${base};
                border: 1px solid ${base};
              }
          '';
      };
    };
  };
}
