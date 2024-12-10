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
  imports = [ inputs.hosts.nixosModule ];
  options.cute.net = {
    enable = cutelib.mkEnabledOption;
    connection = mkOption {
      type = nullOr (enum [ "wired" "wireless" ]);
      default = "wired";
    };
    name = mkOption { type = str; };
    ip = mkOption { type = str; };
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
          nameservers = [ "1.0.0.1" "1.1.1.1" ];
        };
      }
      (mkIf (connection == "wired") {
        systemd.network = {
          networks.${name} = {
            inherit enable name;
            networkConfig.DHCP = "no";
            address = [ "${ip}/24" ];
            routes = [ { Gateway = "192.168.178.1"; } ];
          };
          inherit enable;
        };
        networking.useDHCP = false;
      })
      (mkIf (connection == "wireless") {
        networking = {
          networkmanager = {
            enable = true;
            plugins = lib.mkForce [];
            wifi.backend = "iwd";
          };
          wireless.iwd.enable = true;
        };
        users.users.pagu.extraGroups = [ "networkmanager" ];
      })
    ]);
}
