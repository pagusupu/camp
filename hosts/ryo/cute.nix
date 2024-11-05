{
  inputs,
  pkgs,
  ...
}: {
  cute = {
    desktop = {
      misc = {
        audio = true;
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
      amd = true;
      graphics = true;
      winDualBoot = true;
    };
    net.connection = "wireless";
  };
  networking = {
    hostName = "ryo";
    hostId = "6f257938";
  };
  environment.systemPackages = [pkgs.libreoffice-qt6-fresh];
  imports = [inputs.lix.nixosModules.default];
}
