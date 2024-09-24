{
  config,
  lib,
  cutelib,
  ...
}: {
  options.cute.services.web.jellyseerr = cutelib.mkWebOpt "seer" 5096;
  config = let
    inherit (config.cute.services.web.jellyseerr) enable port;
  in
    lib.mkIf enable (lib.mkMerge [
      {
        assertions = cutelib.assertNginx "jellyseer";
        services.jellyseerr = {
          inherit enable port;
          openFirewall = true;
        };
      }
      {
        assertions = [
          {
            assertion = config.cute.services.web.jellyfin.enable;
            message = "jellyseer requires jellyfin service.";
          }
        ];
      }
    ]);
}
