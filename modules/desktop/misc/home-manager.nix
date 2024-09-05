{
  config,
  lib,
  _lib,
  inputs,
  ...
}: {
  imports = [inputs.home-manager.nixosModules.home-manager];
  options.cute.desktop.misc.home = _lib.mkEnable;
  config = lib.mkIf config.cute.desktop.misc.home {
    home-manager = {
      users.pagu = {
        home = {
          username = "pagu";
          homeDirectory = "/home/pagu";
          stateVersion = "23.05";
        };
        xdg.userDirs = let
          p = "/home/pagu/";
        in {
          enable = true;
          desktop = p + ".local/misc/desktop";
          documents = p + "documents";
          download = p + "downloads";
          pictures = p + "pictures";
          videos = p + "pictures/videos";
        };
      };
      extraSpecialArgs = {inherit inputs;};
      useGlobalPkgs = true;
      useUserPackages = true;
    };
  };
}
