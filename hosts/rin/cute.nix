{pkgs, ...}: {
  cute = {
    desktop = {
      audio = true;
      boot = true;
      fonts = true;
      gtk = true;
      home-manager = true;
      hyprland = true;
      idle = true;
      mako = true;
      tofi = true;
      waybar = true;
      wlogout = true;
    };
    programs = {
      aagl = true;
      alacritty = true;
      discord = false;
      firefox = true;
      misc = true;
      nvim = true;
      prismlauncher = true;
      starship = true;
      steam = true;
      zsh = true;
    };
    services = {
      glance = true;
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
