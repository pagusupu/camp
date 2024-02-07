{
  lib,
  config,
  pkgs,
  ...
}: {
  options.cute.desktop.programs = {
    mako = lib.mkEnableOption "";
    misc = lib.mkEnableOption "";
  };
  config = let
    inherit (config.cute.desktop.programs) mako misc;
  in {
    home-manager.users.pagu = {
      home = lib.mkIf misc {
        packages = with pkgs; [
          cartridges
          imv
          localsend
          ueberzugpp
          xfce.thunar
          yazi
        ];
      };
      services.mako = lib.mkIf mako {
        enable = true;
        anchor = "bottom-left";
        defaultTimeout = 3;
        maxVisible = 3;
        borderSize = 2;
        margin = "14";
        backgroundColor = "#${config.cute.colours.overlay}";
        borderColor = "#${config.cute.colours.iris}";
        textColor = "#${config.cute.colours.text}";
        extraConfig = ''
          [mode=do-not-disturb]
          invisible=1
        '';
      };
    };
    # localsend
    networking.firewall = {
      allowedTCPPorts = [53317];
      allowedUDPPorts = [53317];
    };
  };
}
