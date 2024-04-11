{
  config,
  lib,
  ...
}: let
  inherit (lib) mkEnableOption mkMerge mkIf;
in {
  options.cute.services = {
    fail2ban = mkEnableOption "";
    homeassistant = mkEnableOption "";
  };
  config = let
    inherit (config.cute.services) fail2ban homeassistant;
  in
    mkMerge [
      (mkIf fail2ban {
        services.fail2ban = {
          enable = true;
          bantime-increment = {
            enable = true;
            factor = "16";
          };
        };
      })
      (mkIf homeassistant {
        services.home-assistant = {
          enable = true;
          openFirewall = true;
          # configDir = /storage/services/hass;
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
      })
    ];
}
