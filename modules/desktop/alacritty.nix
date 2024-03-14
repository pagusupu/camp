{
  config,
  lib,
  ...
}: {
  options.cute.desktop.alacritty = lib.mkEnableOption "";
  config = lib.mkIf config.cute.desktop.alacritty {
    home-manager.users.pagu = {
      programs.alacritty = {
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
    };
  };
}
