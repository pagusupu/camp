{
  cute = {
    desktop = {
      misc = {
        audio = true;
        fonts = true;
        home = true;
      };
      hyprland = true;
      mako = true;
      tofi = true;
      waybar = true;
    };
    programs = {
      cli = {
        misc = true;
        nvim = true;
        starship = true;
        zsh = true;
      };
      gui = {
        aagl = true;
        alacritty = true;
        firefox = true;
        misc = true;
        steam = true;
      };
    };
    services.tailscale = true;
    net = {
      ip = "192.168.178.126";
      name = "enp10s0";
    };
    theme.gtk = true;
  };
}
