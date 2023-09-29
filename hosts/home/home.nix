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
        ../../things/misc/user
      ];
      cute.programs = {
        alacritty.enable = true;
        codium.enable = true;
        comma.enable = true;
        htop.enable = true;
        mako.enable = true;
        nixvim.enable = true;
        swaylock.enable = true;
        swayfx.enable = true;
        tofi.enable = true;
        waybar.enable = true;
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
          firefox-wayland
          feishin
          #tui
          htop
          ranger
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
        ];
        sessionVariables = {
          NIXOS_OZONE_WL = "1";
          MOZ_ENABLE_WAYLAND = "1";
          FLAKE = "/home/pagu/Nix";
        };
	programs.git = {
	  enable = true;
	  userName = "pagusupu";
	  userEmail = "me@pagu.cafe";
	};
        stateVersion = "23.05";
      };
    };
  };
}
