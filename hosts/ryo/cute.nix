{pkgs, ...}: {
  cute = {
    desktop = {
      audio = true;
      boot = true;
      fonts = true;
      xdg = true;
      misc = {
        bluetooth = true;
        printing = true;
      };
      de = "plasma";
    };
    programs = {
      cli = {
        btop = true;
        nvim = true;
        shell = true;
        starship = true;
      };
      gui = {
        floorp = true;
        vscode = true;
      };
    };
    services = {
      backend.home-manager = true;
      local.glance = true;
      tailscale.enable = true;
    };
    system = {
      graphics = true;
      winDualBoot = true;
    };
    net.connection = "wireless";
  };
  networking = {
    hostName = "ryo";
    hostId = "6f257938";
  };
  home-manager.users.pagu.home = {
    packages = [ pkgs.obsidian ];
    stateVersion = "24.05";
  };
  # no touchy
  system.stateVersion = "24.05";
}
