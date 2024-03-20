{
  config,
  lib,
  inputs,
  pkgs,
  ...
}: {
  imports = [inputs.agenix.nixosModules.default];
  options.cute.common.system.user = lib.mkEnableOption "";
  config = lib.mkIf config.cute.common.system.user {
    environment.systemPackages = [inputs.agenix.packages.${pkgs.system}.default];
    age = {
      identityPaths = ["/home/pagu/.ssh/id_ed25519"];
      secrets.user = {
        file = ../../secrets/user.age;
        owner = "pagu";
      };
    };
    users.users.pagu = {
      uid = 1000;
      isNormalUser = true;
      extraGroups = ["wheel"];
      shell = pkgs.zsh;
      hashedPasswordFile = config.age.secrets.user.path;
    };
    security.sudo.execWheelOnly = true;
  };
}
