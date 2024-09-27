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
    theme.gtk = true;
    net = {
      ip = "192.168.178.126";
      name = "enp10s0";
    };
    services.tailscale = true;
  };
  networking = {
    hostName = "rin";
    hostId = "6f257938";
  };
}
