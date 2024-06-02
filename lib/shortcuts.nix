{
  config,
  lib,
  _lib,
  ...
}: let
  inherit (lib) mkEnableOption mkOption types listToAttrs;
  inherit (types) bool int str;
  inherit (_lib) setInt setStr mkAssert;
in {
  _module.args._lib = {
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
    assertDocker = mkAssert config.cute.services.docker.enable "requires docker service.";
    assertHm = mkAssert config.cute.desktop.misc.home "requires home-manager service.";
    assertNginx = mkAssert config.cute.services.nginx "requires nginx service.";
    genAttrs' = list: f: listToAttrs (map f list);
  };
}
