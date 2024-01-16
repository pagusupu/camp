{
  config,
  lib,
  ...
}: {
  options.cute.hm.programs.mako.enable = lib.mkEnableOption "";
  config = lib.mkIf config.cute.hm.programs.mako.enable {
    home-manager.users.pagu = {
      services.mako = {
        enable = true;
        anchor = "bottom-left";
        defaultTimeout = 3;
        maxVisible = 3;
        borderSize = 2;
        margin = "14";
        backgroundColor = "#${config.cute.colours.surface}";
        borderColor = "#${config.cute.colours.iris}";
        textColor = "#${config.cute.colours.text}";
        extraConfig = ''
          [mode=do-not-disturb]
          invisible=1
        '';
      };
    };
  };
}
