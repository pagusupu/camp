{
  config,
  lib,
  _lib,
  ...
}: {
  options.cute.programs.gui.rio = lib.mkEnableOption "";
  config = lib.mkIf config.cute.programs.gui.rio {
    assertions = _lib.assertHm;
    home-manager.users.pagu = {
      programs.rio = {
        enable = true;
        settings = {
          confirm-before-quit = false;
          cursor = "_";
          editor = "nvim";
          padding-x = 10;
          fonts = {
            family = "JetBrainsMono Nerd Font";
            size = 16;
          };
          navigation = {
            clickable = true;
            mode = "CollapsedTab";
          };
          renderer = {
            backend = "Automatic";
            disable-unfocused-render = false;
            performance = "High";
          };
        };
      };
    };
  };
}
