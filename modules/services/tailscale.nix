{
  config,
  lib,
  cutelib,
  ...
}: {
  options.cute.services.tailscale = cutelib.mkEnable;
  config = lib.mkIf config.cute.services.tailscale {
    services.tailscale = {
      enable = true;
      openFirewall = true;
    };
  };
}
