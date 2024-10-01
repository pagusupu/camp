{pkgs, ...}: {
  cute = {
    programs = {
      misc = true;
      nvim = true;
      starship = true;
      zsh = true;
    };
    services = {
      minecraft = {
        enable = true;
        server = "modded";
      };
      tailscale = {
        enable = true;
        server = true;
      };
      servers = {
        docker = true;
        nginx.enable = true;
      };
      web = {
        audiobookshelf.enable = true;
        feishin.enable = true;
        freshrss.enable = true;
        immich.enable = true;
        jellyfin.enable = true;
        jellyseerr.enable = true;
        komga.enable = true;
        linkding.enable = true;
        matrix-client.enable = true;
        mealie.enable = true;
        memos.enable = true;
        navidrome.enable = true;
        qbittorrent.enable = true;
        vaultwarden.enable = true;
      };
      comin = true;
      etebase = true;
    };
    net = {
      ip = "192.168.178.182";
      name = "enp37s0";
    };
  };
  networking = {
    domain = "pagu.cafe";
    hostName = "aoi";
    hostId = "a3b49b22";
  };
}
