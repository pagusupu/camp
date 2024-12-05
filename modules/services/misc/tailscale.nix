{
  config,
  lib,
  cutelib,
  ...
}: {
  options.cute.services.tailscale = {
    enable = cutelib.mkEnable;
    server = cutelib.mkEnable;
  };
  config = let
    inherit (config.cute.services.tailscale) enable server;
  in
    lib.mkIf enable {
      age.secrets.tailscale.file = ../../../parts/secrets/tailscale.age;
      services.tailscale = lib.mkMerge [
        {
          enable = true;
          openFirewall = true;
          authKeyFile = config.age.secrets.tailscale.path;
          useRoutingFeatures = "both";
          extraUpFlags = [ "--accept-risk=" ];
        }
        (lib.mkIf server {
          extraUpFlags = [ "--accept-risk=" "--ssh" "--advertise-exit-node" ];
        })
      ];
    };
}
