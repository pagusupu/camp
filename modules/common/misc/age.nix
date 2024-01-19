{
  pkgs,
  lib,
  config,
  inputs,
  ...
}: {
  imports = [inputs.agenix.nixosModules.default];
  options.cute.common.misc.age.enable = lib.mkEnableOption "";
  config = lib.mkIf config.cute.common.misc.age.enable {
    environment.systemPackages = [inputs.agenix.packages.${pkgs.system}.default];
    age.identityPaths = ["/home/pagu/.ssh/id_ed25519"];
  };
}


