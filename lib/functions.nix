{
  config,
  lib,
  cutelib,
  ...
}: let
  inherit (lib) mkOption types;
  inherit (types) bool;
  inherit (cutelib) mkAssert;
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
    mkAssert = a: b: [
      {
        assertion = a;
        message = b;
      }
    ];
    assertDocker = n: mkAssert config.cute.services.backend.docker "${n} requires docker service.";
    assertHm = n: mkAssert config.cute.services.backend.home-manager "${n} requires home-manager service.";
    assertNginx = n: mkAssert config.cute.services.backend.nginx "${n} requires nginx service.";
  };
}
