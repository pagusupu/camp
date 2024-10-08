{
  config,
  lib,
  cutelib,
  ...
}: {
  options.cute.services.homeassistant = cutelib.mkEnable;
  config = lib.mkIf config.cute.services.homeassistant {
    services.home-assistant = {
      enable = true;
      openFirewall = true;
      config = {
        homeassistant = {
          time_zone = "Pacific/Auckland";
          temperature_unit = "C";
          unit_system = "metric";
        };
        # disable next two for onboarding
        default_config = {};
      };
      extraComponents = [
        "fritz"
        "light"
        "wiz"
      ];
    };
  };
}
