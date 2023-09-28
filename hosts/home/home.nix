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
        #inputs.nix-index-database.hmModules.nix-index
      ];
      local.programs = {
        alacritty.enable = true;
        htop.enable = true;
        mako.enable = true;
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
          feishin
          imv
          mpv
          #tui
          htop
          ranger
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
        stateVersion = "23.05";
      };
    };
  };
}
