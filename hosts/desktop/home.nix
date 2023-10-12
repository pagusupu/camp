{
  pkgs,
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
    users.pagu = {
      imports = [
        ../../things/home
        ../../things/misc/home
      ];
      cute.programs = {
        alacritty.enable = true;
        bspwm.enable = true;
        htop.enable = true;
        nixvim.enable = true;
        zsh.enable = true;
      };
      home = {
        username = "pagu";
        homeDirectory = "/home/pagu";
        packages = with pkgs; [
          #games
          osu-lazer-bin
          prismlauncher-qt5
          protontricks
          r2modman
          #apps
          discord
	  dorion
          firefox-wayland
          feishin
          #tui
          htop
          ueberzugpp
          yazi
          #cli
          imv
          p7zip
          #environment
          grim
          slurp
          swaybg
          swayidle
          swaylock-effects
          wl-clipboard
          xdg-utils
          #X
	  xclip
	  rofi
	  maim
	  feh
        ];
        sessionVariables = {
          EDITOR = "nvim";
          FLAKE = "/home/pagu/Nix";
          MOZ_ENABLE_WAYLAND = "1";
          NIXOS_OZONE_WL = "1";
        };
        stateVersion = "23.05";
      };
      programs.git = {
        userName = "pagusupu";
        userEmail = "me@pagu.cafe";
      };
    };
  };
}
