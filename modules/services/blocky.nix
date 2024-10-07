{
  config,
  lib,
  cutelib,
  pkgs,
  ...
}: {
  options.cute.services.blocky = cutelib.mkEnable;
  config = lib.mkIf config.cute.services.blocky {
    services.blocky = {
      enable = true;
      settings = {
        blocking = {
          clientGroupsBlock.default = ["ads"];
          denylists.ads = ["https://raw.githubusercontent.com/StevenBlack/hosts/master/alternates/fakenews/hosts"];
        };
        ports = {
          dns = 56;
          http = 4000;
        };
        upstreams.groups.default = [
          "1.0.0.1"
          "1.1.1.1"
          "8.8.4.4"
          "8.8.8.8"
        ];
        connectIPVersion = "v4";
        prometheus.enable = true;
      };
    };
    networking.firewall = {
      allowedTCPPorts = [56 4000];
      allowedUDPPorts = [56];
    };
    environment.systemPackages = [pkgs.blocky]; # cli
  };
}
