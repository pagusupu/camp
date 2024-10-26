{pkgs, ...}: {
  cute = {
    desktop = {
      misc = {
        audio = true;
        boot = true;
        fonts = true;
        gtk = true;
        xdg = true;
      };
      programs = {
        ags = false;
        hyprland = true;
        idle = true;
        mako = true;
        tofi = true;
        waybar = true;
        wlogout = true;
      };
    };
    programs = {
      cli = {
        btop = true;
        nvim = true;
        starship = true;
        zsh = true;
      };
      gui = {
        aagl = true;
        alacritty = true;
        discord = true;
        floorp = true;
        prismlauncher = true;
        steam = true;
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
    net = {
      ip = "192.168.178.126";
      name = "enp10s0";
    };
  };
  networking = {
    hostName = "rin";
    hostId = "6f257938";
  };
  environment.systemPackages = with pkgs; [
    beets
    easyeffects
    heroic
    radeontop
    sublime-music
    xfce.thunar
  ];
  programs.localsend.enable = true;
}
