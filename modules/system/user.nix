{
  config,
  lib,
  cutelib,
  inputs,
  pkgs,
  ...
}: {
  imports = [inputs.agenix.nixosModules.default];
  options.cute.system.user = cutelib.mkEnabledOption;
  config = lib.mkIf config.cute.system.user (lib.mkMerge [
    {
      age = {
        secrets.user = {
          file = ../../secrets/user.age;
          owner = "pagu";
        };
        identityPaths = ["/etc/ssh/${config.networking.hostName}_ed25519_key"];
      };
      environment.systemPackages = [inputs.agenix.packages.${pkgs.system}.default];
    }
    {
      users.users.pagu = {
        isNormalUser = true;
        extraGroups = ["wheel"];
        uid = 1000;
        hashedPasswordFile = config.age.secrets.user.path;
      };
    }
  ]);
}
