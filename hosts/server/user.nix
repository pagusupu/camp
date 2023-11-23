{config, ...}: {
  age = {
    identityPaths = ["/home/pagu/.ssh/agenix"];
    secrets.userPass = {
      file = ../../secrets/userPass.age;
    };
  };
  users = {
    #mutableUsers = false;
    extraUsers.pagu = {
      isNormalUser = true;
      extraGroups = ["wheel"];
      hashedPasswordFile = config.age.secrets.userPass.path;
    };
  };
}
