{
  config,
  lib,
  _lib,
  ...
}: {
  options.cute.services.homeassistant = _lib.mkEnable;
  config = lib.mkIf config.cute.services.homeassistant {
    services.home-assistant = {
      enable = true;
      openFirewall = true;
      extraComponents = [
        # required for onboarding
        # "esphome"
        # "met"
        # "radiob_browser"
        "fritz"
        "light"
        "wiz"
      ];
      config = {
        default_config = {};
        homeassistant = {
          time_zone = "Pacific/Auckland";
          temperature_unit = "C";
          unit_system = "metric";
        };
      };
    };
  };
}
