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
      age.secrets.tailscale.file = ../../../secrets/tailscale.age;
      services.tailscale = lib.mkMerge [
        {
          enable = true;
          openFirewall = true;
          authKeyFile = config.age.secrets.tailscale.path;
          useRoutingFeatures = lib.mkDefault "client";
        }
        (lib.mkIf server {
          extraUpFlags = ["--ssh"];
          useRoutingFeatures = "server";
        })
        (lib.mkIf (config.networking.hostName == "aoi") {
          extraUpFlags = ["--advertise-exit-node"];
        })
      ];
    };
}
