{
  config,
  lib,
  _lib,
  ...
}: let
  inherit (lib) mkEnableOption mkMerge mkIf;
in {
  options.cute.services = {
    docker = {
      enable = mkEnableOption "";
      feishin = mkEnableOption "";
    };
    homeassistant = mkEnableOption "";
    openssh = mkEnableOption "";
  };
  config = let
    inherit (config.cute.services) docker homeassistant openssh;
  in
    mkMerge [
      (mkIf docker.enable {
        virtualisation = {
          docker = {
            enable = true;
            storageDriver = "btrfs";
          };
          oci-containers.backend = "docker";
        };
      })
      (mkIf docker.feishin {
        assertions = _lib.assertDocker;
        virtualisation.oci-containers.containers."feishin" = {
          image = "ghcr.io/jeffvli/feishin:0.7.1";
          ports = ["9180:9180"];
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
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIqJoNQ+5r3whthoNHP3C++gI/KE6iMgrD81K6xDQ//V" # desktop win
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAqzdZDv69pd3yQEIiq79vRKrDE5PlxINJFhpDvpE/vR" # laptop
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBiWUZRqsWDA78zsv3LJVcWjIiUdnecPoOi8+ZddxRSa" # phone
        ];
      })
    ];
}
