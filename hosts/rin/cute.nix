{pkgs, ...}: {
  cute = {
    desktop = {
      audio = true;
      boot = true;
      fonts = true;
      gtk = true;
      hyprland = true;
      idle = true;
      mako = true;
      tofi = true;
      waybar = true;
      wlogout = true;
      xdg = true;
    };
    programs = {
      cli = {
        btop = true;
        nvim = true;
        starship = true;
        yazi = true;
        zsh = true;
      };
      gui = {
        aagl = true;
        alacritty = true;
        discord = true;
        firefox = true;
        prismlauncher = true;
        steam = true;
      };
    };
    services = {
      glance = true;
      home-manager = true;
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
    easyeffects
    heroic
    keyguard
    radeontop
    sublime-music
    xfce.thunar
  ];
  programs.localsend.enable = true;
}
