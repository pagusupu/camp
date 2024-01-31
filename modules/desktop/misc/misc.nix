{
  config,
  lib,
  pkgs,
  ...
}: {
  options.cute.desktop.misc = {
    polkit = lib.mkEnableOption "";
    greetd = lib.mkEnableOption "";
  };
  config = let
    inherit (config.cute.desktop.misc) polkit greetd;
  in {
    # polkit
    security.polkit.enable = lib.mkIf polkit true;
    environment.systemPackages = lib.mkIf polkit [pkgs.libsForQt5.polkit-kde-agent];
    home-manager.users.pagu.wayland.windowManager.hyprland.settings.exec-once = lib.mkIf polkit ["/nix/store/$(ls -la /nix/store | grep polkit-kde-agent | grep '^d' | awk '{print $9}')/libexec/polkit-kde-authentication-agent-1 &"];
    # greetd
    services.greetd = lib.mkIf greetd {
      enable = true;
      settings = {
        default_session = {
          command = "${pkgs.greetd.tuigreet}/bin/tuigreet --asterisks --remember --cmd Hyprland";
          user = "pagu";
        };
      };
    };
  };
}
