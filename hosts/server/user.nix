{
  users = {
    #mutableUsers = false;
    extraUsers.pagu = {
      isNormalUser = true;
      extraGroups = ["wheel"];
    };
  };
}
