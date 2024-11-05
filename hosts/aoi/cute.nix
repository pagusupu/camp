{inputs, ...}: {
  cute = {
    programs.cli = {
      btop = true;
      nvim = true;
      starship = true;
      zsh = true;
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
    system = {
      amd = true;
      graphics = true;
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
  imports = [inputs.lix.nixosModules.default];
}
