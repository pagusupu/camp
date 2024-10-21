{
  cute = {
    programs.cli = {
      btop = true;
      nvim = true;
      starship = true;
      yazi = true;
      zsh = true;
    };
    services.tailscale = {
      enable = true;
      server = true;
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
}
