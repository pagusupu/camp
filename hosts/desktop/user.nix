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
        ../../user
	../../system/misc/colours.nix
      ];
      cute.programs = {
        alacritty.enable = true;
        bspwm.enable = true;
	dunst.enable = true;
        firefox.enable = true;
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
	  protonup-ng
          r2modman
          #apps
          discord
          #feishin
          #tui
          ueberzugpp
          yazi
          #environment
          xclip
          maim
          feh
        ];
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
