{
  config,
  lib,
  _lib,
  ...
}: {
  options.cute.net = {
    enable = _lib.mkEnabledOption;
    name = lib.mkOption {type = lib.types.str;};
    ip = lib.mkOption {type = lib.types.str;};
  };
  config = let
    inherit (config.cute.net) enable name ip;
  in
    lib.mkIf enable {
      networking = {
        enableIPv6 = false;
        useDHCP = false;
      };
      systemd.network = {
        enable = true;
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
    };
}
