{
  config,
  lib,
  ...
}: {
  options.cute.xserver.common.lightdm = {
    enable = lib.mkEnableOption "";
  };
  config = lib.mkIf config.cute.xserver.common.lightdm.enable {
    services.xserver.displayManager = {
      lightdm.greeters.mini = {
        enable = true;
        user = "pagu";
        extraConfig = ''
          [greeter]
          show-password-label = false
          invalid-password-text = Incorrect Password
          show-input-cursor = false
          password-alignment = left
          [greeter-theme]
          font = "Nunito"
          text-color = "#${config.cute.colours.primary.fg}"
          error-color = "#${config.cute.colours.normal.red}"
          background-color = "#${config.cute.colours.primary.bg}"
          window-color = "#${config.cute.colours.primary.bg}"
          border-color= "#${config.cute.colours.primary.bg}"
          password-color = "#${config.cute.colours.primary.fg}"
          password-background-color = "#${config.cute.colours.normal.black}"
          password-border-color = "#${config.cute.colours.primary.main}"
          password-border-radius =  0em
          background-image = ""
        '';
      };
    };
  };
}
