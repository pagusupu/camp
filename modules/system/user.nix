{
  config,
  lib,
  cutelib,
  inputs,
  ...
}: {
  imports = [ inputs.agenix.nixosModules.default ];
  options.cute.system.user = cutelib.mkEnabledOption;
  config = lib.mkIf config.cute.system.user {
    age = {
      secrets.user = {
        file = ../../parts/secrets/user.age;
        owner = "pagu";
      };
      identityPaths = [ "/etc/ssh/${config.networking.hostName}_ed25519_key" ];
    };
    users.users.pagu = {
      isNormalUser = true;
      extraGroups = [ "wheel" ];
      uid = 1000;
      hashedPasswordFile = config.age.secrets.user.path;
    };
  };
}
