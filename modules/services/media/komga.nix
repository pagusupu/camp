{
  config,
  lib,
  cutelib,
  ...
}: {
  options.cute.services.media.komga = cutelib.mkEnable;
  config = lib.mkIf config.cute.services.media.komga {
    assertions = cutelib.assertNginx "komga";
    services = let
      port = 8097;
    in {
      komga = {
        enable = true;
        inherit port;
        openFirewall = true;
      };
      nginx = cutelib.host "kmga" port "" "";
    };
  };
}
