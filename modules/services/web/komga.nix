{
  config,
  lib,
  _lib,
  ...
}: {
  options.cute.services.web.komga = _lib.mkWebOpt "kmga" 8097;
  config = let
    inherit (config.cute.services.web.komga) enable port;
  in
    lib.mkIf enable {
      assertions = _lib.assertNginx;
      services.komga = {
        inherit enable port;
        openFirewall = true;
      };
    };
}
