{
  pkgs,
  cutelib,
  ...
}: {
  cute = {
    desktop = {
      audio = true;
      boot = true;
      de = "hyprland";
      fonts = true;
      gtk = true;
      misc.printing = true;
      xdg = true;
    };
    programs = {
      cli = {
        btop = true;
        nvim = true;
        shell = true;
        starship = true;
      };
      gui = {
        aagl = true;
        alacritty = true;
        discord = true;
        floorp = true;
        prismlauncher = true;
        steam = true;
        vscode = true;
      };
    };
    services = {
      backend.home-manager = true;
      local.glance = true;
      tailscale.enable = true;
    };
    system = {
      hardware = "amd";
      winDualBoot = true;
    };
    dark = true;
    net.connection = "wireless";
  };
  networking = {
    hostName = "rin";
    hostId = "6f257938";
  };
  security.sudo-rs.wheelNeedsPassword = false;
  programs.localsend.enable = true;
  home-manager.users.pagu.home = {
    packages = with pkgs;
      [
        gnome-calculator
        kdePackages.okular
        obsidian
        pwvucontrol
        radeontop
        xfce.thunar
      ]
      ++ (with cutelib.unstable; [
        feishin
        heroic
      ]);
    stateVersion = "23.05";
  };
  # no touchy
  system.stateVersion = "23.11";
}
