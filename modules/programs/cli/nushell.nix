{
  config,
  lib,
  cutelib,
  pkgs,
  ...
}: {
  options.cute.programs.cli.nushell = cutelib.mkEnable;
  config = lib.mkIf config.cute.programs.cli.nushell {
    environment.systemPackages = [pkgs.nushell];
  };
}
