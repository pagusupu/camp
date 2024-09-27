{
  cute = {
    desktop = {
      audio = true;
      boot = true;
      fonts = true;
      home-manager = true;
      hyprland = true;
      mako = true;
      tofi = true;
      waybar = true;
    };
    programs = {
      aagl = true;
      alacritty = true;
      firefox = true;
      misc = true;
      nvim = true;
      starship = true;
      steam = true;
      zsh = true;
    };
    net = {
      ip = "192.168.178.126";
      name = "enp10s0";
    };
    services.tailscale = true;
    system.winDualBoot = true;
    theme.gtk = true;
  };
  networking = {
    hostName = "rin";
    hostId = "6f257938";
  };
}
