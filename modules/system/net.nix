{
  config,
  lib,
  cutelib,
  inputs,
  ...
}: let
  inherit (lib) mkOption types mkMerge mkIf;
  inherit (types) nullOr enum str;
in {
  imports = [inputs.hosts.nixosModule];
  options.cute.net = {
    enable = cutelib.mkEnabledOption;
    connection = mkOption {
      type = nullOr (enum ["wired" "wireless"]);
      default = "wired";
    };
    name = mkOption {type = str;};
    ip = mkOption {type = str;};
  };
  config = let
    inherit (config.cute.net) enable name ip connection;
  in
    mkIf enable (mkMerge [
      {
        networking = {
          stevenBlackHosts = {
            enable = true;
            blockFakenews = true;
            blockGambling = true;
          };
          enableIPv6 = false;
        };
      }
      (mkIf (connection == "wired") {
        systemd.network = {
          inherit enable;
          networks.${name} = {
            inherit enable name;
            networkConfig = {
              DHCP = "no";
              DNSSEC = "yes";
              DNSOverTLS = "yes";
              DNS = ["1.0.0.1" "1.1.1.1"];
            };
            address = ["${ip}/24"];
            routes = [{Gateway = "192.168.178.1";}];
          };
        };
        networking.useDHCP = false;
      })
      (mkIf (connection == "wireless")
        {
          networking = {
            nameservers = ["1.0.0.1" "1.1.1.1"];
            networkmanager = {
              enable = true;
              wifi.backend = "iwd";
            };
            wireless.iwd.enable = true;
          };
          users.users.pagu.extraGroups = ["networkmanager"];
        })
    ]);
}
