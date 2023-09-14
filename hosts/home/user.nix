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
        ../../things/misc/colours.nix
        ../../things/misc/theme.nix
        ../../things/misc/cursor.nix
        ../../things/misc/desktop.nix
      ];
      local.programs = {
        alacritty.enable = true;
        zsh.enable = true;
        tofi.enable = true;
        waybar.enable = true;
        htop.enable = true;
        neofetch.enable = true;
        swaylock.enable = true;
        mako.enable = true;
        swayfx.enable = true;
      };
      home = {
        username = "pagu";
        homeDirectory = "/home/pagu";
        packages = with pkgs; [
          #games
          protontricks
          protonup-ng
          prismlauncher-qt5
          #misc
          htop
          ranger
          p7zip
          vim
          #apps
          mpv
          imv
          firefox-wayland
          discord
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
        ];
        sessionVariables = {
          NIXOS_OZONE_WL = "1";
          MOZ_ENABLE_WAYLAND = "1";
        };
        stateVersion = "23.05";
      };
    };
  };
}
