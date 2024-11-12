{pkgs, ...}: {
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
        vscode = true;
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
    net.connection = "wireless";
  };
  networking = {
    hostName = "rin";
    hostId = "6f257938";
  };
  security.sudo-rs.wheelNeedsPassword = false;
  programs.localsend.enable = true;
  home-manager.users.pagu.home = {
    packages = with pkgs; [
      adwsteamgtk
      easyeffects
      heroic
      kdePackages.okular
      radeontop
      rclone
      xfce.thunar
    ];
    stateVersion = "23.05";
  };
  # no touchy
  system.stateVersion = "23.11";
}
