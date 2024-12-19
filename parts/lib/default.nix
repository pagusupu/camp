{
  config,
  lib,
  cutelib,
  inputs,
  pkgs,
  ...
}: let
  inherit (lib) mkOption types;
  inherit (types) bool;
  inherit (cutelib) mkAssert SSL;
  inherit (inputs) stable unstable;
  inherit (pkgs) system;
  inherit (config.cute.services.backend) docker home-manager nginx;
in {
  _module.args.cutelib = {
    mkEnable = mkOption {
      default = false;
      type = bool;
    };
    mkEnabledOption = mkOption {
      default = true;
      type = bool;
    };

    stable = stable.legacyPackages.${system};
    unstable = unstable.legacyPackages.${system};

    mkAssert = a: b: [
      {
        assertion = a;
        message = b;
      }
    ];
    assertDocker = n: mkAssert docker "${n} requires docker service.";
    assertHm = n: mkAssert home-manager "${n} requires home-manager service.";
    assertNginx = n: mkAssert nginx "${n} requires nginx service.";

    SSL = {
      enableACME = true;
      forceSSL = true;
    };
    host = subdomain: port: websocket: extraConfig: {
      virtualHosts."${subdomain}.${config.networking.domain}" =
        {
          locations."/" = {
            proxyPass = "http://localhost:${builtins.toString port}";
            proxyWebsockets =
              if (websocket == "true")
              then true
              else false;
            inherit extraConfig;
          };
        }
        // SSL;
    };
  };
}
