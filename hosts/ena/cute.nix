{
  cute = {
    programs.cli = {
      btop = true;
      fish = true;
      nvim = true;
      starship = true;
    };
    services = {
      tailscale = {
        enable = true;
        server = true;
      };
      backend.home-manager = true;
    };
    net = {
      ip = "192.168.178.82";
      name = "eno1";
    };
  };
  networking = {
    hostName = "ena";
    hostId = "c184b450";
  };
  home-manager.users.pagu.home = {
    #packages = [];
    stateVersion = "23.05";
  };
  # no touchy
  system.stateVersion = "23.11";
}
