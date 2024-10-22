{
  config,
  lib,
  cutelib,
  inputs,
  pkgs,
  ...
}: {
  options.cute.desktop.programs.ags = cutelib.mkEnable;
  config = lib.mkIf config.cute.desktop.programs.ags {
    home-manager.users.pagu = {
      programs.ags = {
        enable = true;
        extraPackages = with inputs.ags.packages.${pkgs.system}; [
          apps
          auth
          hyprland
          network
          notifd
          tray
          wireplumber
        ];
      };
      imports = [inputs.ags.homeManagerModules.default];
    };
    security.pam.services.astal-auth = {};
  };
}
