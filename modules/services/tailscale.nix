{
  config,
  lib,
  cutelib,
  ...
}: {
  options.cute.services.tailscale = cutelib.mkEnable;
  config = lib.mkIf config.cute.services.tailscale {
    age.secrets.tailscale.file = ../../secrets/tailscale.age;
    services.tailscale = {
      enable = true;
      openFirewall = true;
      authKeyFile = config.age.secrets.tailscale.path;
      extraUpFlags = ["--ssh" "--advertise-exit-node"];
      useRoutingFeatures = "server";
    };
  };
}
