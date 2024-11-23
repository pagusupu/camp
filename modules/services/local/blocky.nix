{
  config,
  lib,
  cutelib,
  pkgs,
  ...
}: {
  options.cute.services.local.blocky = cutelib.mkEnable;
  config = lib.mkIf config.cute.services.local.blocky {
    services.blocky = {
      enable = true;
      settings = {
        blocking = {
          clientGroupsBlock.default = [ "ads" ];
          denylists.ads = [ "https://raw.githubusercontent.com/StevenBlack/hosts/master/alternates/fakenews/hosts" ];
        };
        upstreams.groups.default = [
          "1.0.0.1"
          "1.1.1.1"
        ];
        connectIPVersion = "v4";
        ports.dns = 56;
      };
    };
    networking.firewall = {
      allowedTCPPorts = [ 56 ];
      allowedUDPPorts = [ 56 ];
    };
    environment.systemPackages = [ pkgs.blocky ]; # cli
  };
}
