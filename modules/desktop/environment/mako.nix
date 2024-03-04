{
  config,
  lib,
  ...
}: {
  options.cute.desktop.environment.mako = lib.mkEnableOption "";
  config = lib.mkIf config.cute.desktop.environment.mako {
    home-manager.users.pagu = {
      services.mako = {
        enable = true;
        anchor = "bottom-left";
        defaultTimeout = 3;
        maxVisible = 3;
        borderSize = 2;
        borderRadius = 6;
        margin = "14";
        backgroundColor = "#" + config.cute.colours.overlay;
        borderColor = "#" + config.cute.colours.iris;
        textColor = "#" + config.cute.colours.text;
        extraConfig = ''
          [mode=do-not-disturb]
          invisible=1
        '';
      };
    };
  };
}
