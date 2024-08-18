{
  config,
  lib,
  ...
}: let
  inherit (lib) mkEnableOption mkMerge mkIf;
in {
  options.cute.services = {
    docker = mkEnableOption "";
    homeassistant = mkEnableOption "";
    openssh = mkEnableOption "";
  };
  config = let
    inherit (config.cute.services) docker homeassistant openssh;
  in
    mkMerge [
    (mkIf docker {
      virtualisation = {
          docker = {
            enable = true;
            storageDriver = "btrfs";
          };
          oci-containers.backend = "docker";
        };
    })
      (mkIf homeassistant {
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
      })
      (mkIf openssh {
        services.openssh = {
          enable = true;
          settings = {
            PasswordAuthentication = false;
            PermitRootLogin = "no";
          };
        };
        users.users.pagu.openssh.authorizedKeys.keys = [
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMGwCFQYJB+4nhIqktQwJemynSOEP/sobnV2vESSY3tk" # rin
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIqJoNQ+5r3whthoNHP3C++gI/KE6iMgrD81K6xDQ//V" # desktop win
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAqzdZDv69pd3yQEIiq79vRKrDE5PlxINJFhpDvpE/vR" # laptop
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBiWUZRqsWDA78zsv3LJVcWjIiUdnecPoOi8+ZddxRSa" # phone
        ];
      })
    ];
}
