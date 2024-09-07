{
  config,
  lib,
  cutelib,
  ...
}: {
  options.cute = {
    pubkeys = {
      aoi = lib.mkOption {type = lib.types.str;};
      ena = lib.mkOption {type = lib.types.str;};
      rin = lib.mkOption {type = lib.types.str;};
    };
    enabled.ssh = cutelib.mkEnabledOption;
    services.openssh = lib.mkEnableOption "";
  };
  config = let
    inherit (config.cute) pubkeys enabled services;
  in
    lib.mkMerge [
      {
        cute.pubkeys = {
          aoi = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIExuEEnRUnoo1qZVnvLUtvXqCcBd7DcDJkohVCg0Qbij";
          ena = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDM4qA5VHz8pRZMmEZk06ber5mm3apBexIwkc5pIlQvE";
          rin = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMGwCFQYJB+4nhIqktQwJemynSOEP/sobnV2vESSY3tk";
        };
      }
      (lib.mkIf enabled.ssh {
        services.openssh = {
          enable = true;
          knownHosts = {
            aoi = lib.mkIf (config.networking.hostName != "aoi") {
              extraHostNames = ["192.168.178.182"];
              publicKey = pubkeys.aoi;
            };
            "github.com".publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOMqqnkVzrm0SdG6UOoqKLsabgH5C9okWi0dh2l9GKJl";
          };
          hostKeys = [
            {
              comment = "${config.networking.hostName} host";
              path = "/etc/ssh/${config.networking.hostName}_ed25519_key";
              type = "ed25519";
            }
          ];
        };
      })
      (lib.mkIf services.openssh {
        services.openssh = {
          enable = true;
          settings = {
            PasswordAuthentication = false;
            PermitRootLogin = "no";
          };
        };
        users.users.pagu.openssh.authorizedKeys.keys = [
          pubkeys.rin
          #"ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIcZJ0IEzuvGNglNevP/pSpHNYd+iJwrpRO2yK8mg4lt"
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIqJoNQ+5r3whthoNHP3C++gI/KE6iMgrD81K6xDQ//V" # desktop win
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAqzdZDv69pd3yQEIiq79vRKrDE5PlxINJFhpDvpE/vR" # laptop
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILBMiF9xzJshgudYgsmkfWa3+zfeCayH72dKmjDUyktS" # phone
        ];
      })
    ];
}
