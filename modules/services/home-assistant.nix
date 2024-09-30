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
      extraComponents = [
        "fritz"
        "light"
        "wiz"
      ];
      config = {
        homeassistant = {
          time_zone = "Pacific/Auckland";
          temperature_unit = "C";
          unit_system = "metric";
        };
        default_config = {};
      };
    };
  };
}
