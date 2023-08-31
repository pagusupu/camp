{
  pkgs,
  config,
  inputs,
  ...
}: {
    users = {
      extraUsers.pagu = {
        isNormalUser = true;
        extraGroups = ["wheel"];
        shell = pkgs.zsh;
      };
    };
    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;
      extraSpecialArgs = {inherit inputs;};
      users.pagu = {config, ...}: {
        imports = [
          ../../things/home
          ../../things/misc/user.nix
        ];
        local.programs = {
          alacritty.enable = true;
          hyprland.config = true;     
          zsh.enable = true;
          tofi.enable = true;
          waybar.enable = true;
          htop.enable = true;
          neofetch.enable = true;
          swaylock.enable = true;
	  neovim.enable = true;
        };
      home = {
        username = "pagu";
        homeDirectory = "/home/pagu";
        packages = with pkgs; [
          #games
          protontricks
          protonup-ng
          xivlauncher
          prismlauncher-qt5
          #misc
          htop
          ranger 
          p7zip
          #apps
	  mpv
          imv
          firefox-wayland
	  armcord
          feishin
          #environment
          xdg-utils
          wl-clipboard
          wl-screenrec
          grim
          slurp
          swayidle
          swaylock-effects
          swaybg
          mako
        ];
        sessionVariables = {
          NIXOS_OZONE_WL = "1";
          MOZ_ENABLE_WAYLAND = "1";
        };
        stateVersion = "23.05";
      };
      programs.git = {
        enable = true;
	userName = "pagusupu";
	userEmail = "me@pagu.cafe";
      };
    };
  };
}

