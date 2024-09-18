{
  config,
  lib,
  cutelib,
  ...
}: let
  inherit (lib) mkEnableOption mkOption types;
  inherit (types) bool int str;
  inherit (cutelib) setInt setStr mkAssert;
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
    setInt = dint:
      mkOption {
        default = dint;
        type = int;
        readOnly = true;
      };
    setStr = dstr:
      mkOption {
        default = dstr;
        type = str;
        readOnly = true;
      };
    mkWebOpt = dns: port: {
      enable = mkEnableOption "";
      dns = setStr dns;
      port = setInt port;
    };
    mkAssert = a: b: [
      {
        assertion = a;
        message = b;
      }
    ];
    assertDocker = n: mkAssert config.cute.services.servers.docker "${n} requires docker service.";
    assertHm = n: mkAssert config.cute.desktop.misc.home "${n} requires home-manager service.";
    assertNginx = n: mkAssert config.cute.services.servers.nginx "${n} requires nginx service.";
  };
}
