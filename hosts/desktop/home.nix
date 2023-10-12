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
	rofi.enable = true;
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
          feishin
          #tui/cli
          htop
          ueberzugpp
          yazi
          p7zip
          #environment
	  xclip
	  maim
	  feh
        ];
        sessionVariables = {
          EDITOR = "nvim";
          FLAKE = "/home/pagu/Nix";
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
