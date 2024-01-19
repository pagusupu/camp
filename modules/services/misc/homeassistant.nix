{
  lib,
  config,
  ...
}: {
  options.cute.services.misc.homeassistant = lib.mkEnableOption "";
  config = let
    domain = "home.${config.cute.services.web.domain}";
  in
    lib.mkIf config.cute.services.misc.homeassistant {
      services = {
        home-assistant = {
          enable = true;
          openFirewall = true;
          extraComponents = [
            # required for onboarding
            # "esphome"
            # "met"
            # "radiob_browser"
            "cups"
            "fritz"
            "light"
            "seventeentrack"
            "tuya"
            "webostv"
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
        nginx.virtualHosts."${domain}" = {
          forceSSL = true;
          enableACME = true;
          locations."/".proxyPass = "http://127.0.0.1:8123";
        };
      };
      nixpkgs.config.permittedInsecurePackages = ["openssl-1.1.1w"]; # https://nixos.wiki/wiki/Home_Assistant#OpenSSL_1.1_is_marked_as_insecure.2C_refusing_to_evaluate
    };
}
