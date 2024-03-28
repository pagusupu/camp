{
  config,
  lib,
  ...
}: {
  options.cute.common.system.networking = {
    enable = lib.mkEnableOption "";
    wireless = lib.mkEnableOption "";
    wired = {
      enable = lib.mkEnableOption "";
      interface = lib.mkOption {type = lib.types.str;};
      ip = lib.mkOption {type = lib.types.str;};
    };
  };
  config = let
    inherit (config.cute.common.system.networking) enable wireless wired;
  in {
    networking = lib.mkIf enable {
      firewall.enable = true;
      enableIPv6 = false;
      useDHCP = false;
      wireless = lib.mkIf wireless {
        enable = true;
        userControlled.enable = true;
      };
    };
    systemd.network = lib.mkIf wired.enable {
      enable = true;
      networks.${wired.interface} = {
        name = wired.interface;
        networkConfig = {
          DHCP = "no";
          DNSSEC = "yes";
          DNSOverTLS = "yes";
          DNS = ["1.0.0.1" "1.1.1.1"];
        };
        address = ["${wired.ip}/24"];
        routes = [{routeConfig.Gateway = "192.168.178.1";}];
      };
    };
  };
}
