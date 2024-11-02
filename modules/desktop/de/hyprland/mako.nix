{
  config,
  lib,
  cutelib,
  ...
}: {
  options.cute.desktop.programs.mako = cutelib.mkEnable;
  config = lib.mkIf config.cute.desktop.programs.mako {
    assertions = cutelib.assertHm "mako";
    home-manager.users.pagu = {
      services.mako = with config.wh.colours; {
        enable = true;
        anchor = "top-right";
        defaultTimeout = 3;
        maxVisible = 3;
        borderSize = 2;
        borderRadius = 6;
        margin = "6";
        backgroundColor = overlay;
        borderColor = iris;
        textColor = text;
      };
    };
  };
}
