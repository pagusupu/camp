{
  lib,
  config,
  ...
}: {
  options.cute.services.homeassistant.enable = lib.mkEnableOption "";
  config = lib.mkIf config.cute.services.homeassistant.enable {
    services.home-assistant = {
      enable = true;
      openFirewall = true;
      extraComponents = [
        "esphome"
        "fritz"
        "google_translate"
        "light"
        "met"
        "radio_browser"
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
