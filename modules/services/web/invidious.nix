{
  config,
  lib,
  cutelib,
  ...
}: {
  options.cute.services.web.invidious = cutelib.mkWebOpt "tube" 8099;
  config = let
    inherit (config.cute.services.web.invidious) enable port;
  in
    lib.mkIf enable {
      assertions = cutelib.assertNginx "invidious";
      services.invidious = {
        inherit enable port;
        settings = {
          captcha_enabled = false;
          registration_enabled = false;
          default_user_preferences = {
            default_home = "Subscriptions";
            quality = "dash";
          };
          db.user = "invidious";
          domain = "${config.cute.net.ip}:${builtins.toString port}";
          external_port = 80;
        };
      };
      networking.firewall.allowedTCPPorts = [port];
    };
}
