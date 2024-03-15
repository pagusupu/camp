{
  config,
  lib,
  pkgs,
  ...
}: {
  options.cute.desktop = {
    alacritty = lib.mkEnableOption "";
    programs = lib.mkEnableOption "";
  };
  config = let
    inherit (config.cute.desktop) alacritty programs;
  in {
    home-manager.users.pagu = {
      programs.alacritty = lib.mkIf alacritty {
        enable = true;
        settings = {
          cursor = {
            style = "Underline";
            unfocused_hollow = false;
          };
          font = {
            size = 12;
            normal = {
              family = "MonaspiceNe Nerd Font";
              style = "Regular";
            };
          };
          window = {
            dynamic_title = false;
            padding = {
              x = 10;
              y = 10;
            };
          };
        };
      };
      home = lib.mkIf programs {
        packages = with pkgs; [
          localsend
          pwvucontrol
          ueberzugpp
        ];
      };
    };
    # localsend
    networking.firewall = lib.mkIf programs {
      allowedTCPPorts = [53317];
      allowedUDPPorts = [53317];
    };
  };
}
