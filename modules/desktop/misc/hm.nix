{
  config,
  lib,
  inputs,
  ...
}: {
  imports = [inputs.home-manager.nixosModules.home-manager];
  options.cute.desktop.misc.hm = lib.mkEnableOption "";
  config = lib.mkIf config.cute.desktop.misc.hm {
    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;
      extraSpecialArgs = {inherit inputs;};
      users.pagu = {
        home = {
          username = "pagu";
          homeDirectory = "/home/pagu";
          stateVersion = "23.05";
        };
        programs.git = {
          enable = true;
          userName = "pagusupu";
          userEmail = "me@pagu.cafe";
        };
      };
    };
  };
}
