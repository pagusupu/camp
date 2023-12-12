{config, pkgs, ...}: {
  age = {
    identityPaths = ["/home/pagu/.ssh/id_ed25519"];
    secrets.user = {
      file = ../../secrets/user.age;
    };
  };
  users = {
 #   mutableUsers = false;
    extraUsers.pagu = {
      isNormalUser = true;
      extraGroups = ["wheel"];
      shell = pkgs.zsh;
      hashedPasswordFile = config.age.secrets.user.path;
    };
  };
}
