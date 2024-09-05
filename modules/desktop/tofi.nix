{
  config,
  lib,
  _lib,
  ...
}: {
  options.cute.desktop.tofi = _lib.mkEnable;
  config = lib.mkIf config.cute.desktop.tofi {
    home-manager.users.pagu = {
      programs.tofi = {
        enable = true;
      };
    };
  };
}
