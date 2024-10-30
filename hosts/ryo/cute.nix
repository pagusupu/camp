{inputs, ...}: {
  cute = {
    desktop = {
      misc = {
        auto = true;
        bluetooth = true;
        boot = true;
        fonts = true;
        xdg = true;
      };
      programs.plasma = true;
    };
    programs = {
      cli = {
        btop = true;
        nvim = true;
        starship = true;
        zsh = true;
      };
      gui.floorp = true;
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
  programs.localsend.enable = true;
  imports = [inputs.lix.nixosModules.default];
}
