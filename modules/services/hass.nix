{
  lib,
  config,
  ...
}: {
  options.cute.services.hass = lib.mkEnableOption "";
  config = lib.mkIf config.cute.services.hass {
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
    nixpkgs.config.permittedInsecurePackages = ["openssl-1.1.1w"]; # https://nixos.wiki/wiki/Home_Assistant#OpenSSL_1.1_is_marked_as_insecure.2C_refusing_to_evaluate
  };
}