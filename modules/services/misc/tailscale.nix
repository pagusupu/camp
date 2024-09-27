{
  config,
  lib,
  cutelib,
  ...
}: {
  options.cute.services.tailscale = cutelib.mkEnable;
  config = lib.mkIf config.cute.services.tailscale {
    age.secrets.tailscale.file = ../../../secrets/tailscale.age;
    services.tailscale = lib.mkMerge [
      {
        enable = true;
        openFirewall = true;
        authKeyFile = config.age.secrets.tailscale.path;
        useRoutingFeatures = lib.mkDefault "client";
      }
      (lib.mkIf (config.networking.hostName == "aoi") {
        extraUpFlags = ["--ssh" "--advertise-exit-node"];
        useRoutingFeatures = "server";
      })
    ];
  };
}
