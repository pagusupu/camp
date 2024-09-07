{
  config,
  lib,
  cutelib,
  ...
}: {
  options.cute.desktop.mako = cutelib.mkEnable;
  config = lib.mkIf config.cute.desktop.mako {
    assertions = cutelib.assertHm "mako";
    home-manager.users.pagu = {
      services.mako = with config.colours.base16; {
        enable = true;
        anchor = "bottom-left";
        defaultTimeout = 3;
        maxVisible = 3;
        borderSize = 2;
        borderRadius = 6;
        margin = "6";
        backgroundColor = "#" + A3;
        borderColor = "#" + B6;
        textColor = "#" + A6;
      };
    };
  };
}
