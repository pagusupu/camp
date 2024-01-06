{
  config,
  pkgs,
  inputs,
  ...
}: {
  age = {
    identityPaths = ["/home/pagu/.ssh/agenix"];
    secrets.deskPass.file = ../../secrets/deskPass.age;
  };
  users = {
    mutableUsers = true;
    extraUsers.pagu = {
      isNormalUser = true;
      extraGroups = ["wheel"];
      shell = pkgs.zsh;
      hashedPasswordFile = config.age.secrets.deskPass.path;
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
      cute.hm-programs = {
        alacritty.enable = true;
        bspwm.enable = true;
        dunst.enable = false;
        firefox.enable = true;
        rofi.enable = true;
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
          #feishin - failed build
          #tui
          eza
          ueberzugpp
          yazi
          #environment
          xclip
          maim
          feh
        ];
        sessionVariables = {
          FLAKE = "/home/pagu/flake";
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
