{
  config,
  lib,
  cutelib,
  ...
}: {
  options.cute.services.web.komga = cutelib.mkWebOpt "kmga" 8097;
  config = let
    inherit (config.cute.services.web.komga) enable port;
  in
    lib.mkIf enable {
      assertions = cutelib.assertNginx "komga";
      services.komga = {
        inherit enable port;
        openFirewall = true;
      };
    };
}
