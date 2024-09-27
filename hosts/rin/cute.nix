{
  cute = {
    desktop = {
      audio = true;
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
    services.tailscale = true;
    net = {
      ip = "192.168.178.126";
      name = "enp10s0";
    };
    theme.gtk = true;
  };
  networking = {
    hostName = "rin";
    hostId = "6f257938";
  };
}
