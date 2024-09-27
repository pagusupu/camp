{
  cute = {
    programs.cli = {
      misc = true;
      nvim = true;
      starship = true;
      zsh = true;
    };
    services = {
      etebase = true;
      feishin = true;
      homeassistant = true;
      qbittorrent = true;
      tailscale = true;
      minecraft = {
        enable = true;
        server = "modded";
      };
      servers = {
        docker = true;
        nginx.enable = true;
      };
      web = {
        audiobookshelf.enable = true;
        freshrss.enable = true;
        jellyfin.enable = true;
        jellyseerr.enable = true;
        komga.enable = true;
        linkding.enable = true;
        matrix-client.enable = true;
        mealie.enable = true;
        memos.enable = true;
        navidrome.enable = true;
        nextcloud.enable = true;
        vaultwarden.enable = true;
      };
    };
    net = {
      ip = "192.168.178.182";
      name = "enp37s0";
    };
  };
}
