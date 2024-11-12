{
  cute = {
    programs.cli = {
      btop = true;
      fish = true;
      nvim = true;
      starship = true;
    };
    services = {
      backend = {
        docker = true;
        home-manager = true;
        nginx = true;
      };
      cloud = {
        etebase = true;
        immich = true;
        linkding = true;
        mealie = true;
        memos = true;
        vaultwarden = true;
      };
      local = {
        blocky = true;
        home-assistant = true;
      };
      media = {
        freshrss = true;
        jellyfin = true;
        komga = true;
        navidrome = true;
        qbittorrent = true;
      };
      minecraft = {
        enable = true;
        server = "modded";
      };
      tailscale = {
        enable = true;
        server = true;
      };
    };
    net = {
      ip = "192.168.178.182";
      name = "enp37s0";
    };
    system.graphics = true;
  };
  networking = {
    domain = "pagu.cafe";
    hostName = "aoi";
    hostId = "a3b49b22";
  };
  home-manager.users.pagu.home = {
    # packages = [];
    stateVersion = "23.05";
  };
  # no touchy
  system.stateVersion = "23.11";
}
