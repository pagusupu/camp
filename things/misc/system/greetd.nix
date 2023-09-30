{pkgs, ...}: {
  services.greetd.settings.default_session = {
    command = "${pkgs.greetd.tuigreet}/bin/tuigreet -r -t --asterisks -c sway";
    user = "pagu";
  };
}
