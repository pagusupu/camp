{
  config,
  lib,
  inputs,
  ...
}: {
  imports = [inputs.home-manager.nixosModules.home-manager];
  options.cute.home = {
    enable = lib.mkEnableOption "";
    xdg = lib.mkEnableOption "";
  };
  config = let
    inherit (config.cute.home) enable xdg;
  in {
    home-manager = lib.mkIf enable {
      useGlobalPkgs = true;
      useUserPackages = true;
      extraSpecialArgs = {inherit inputs;};
      users.pagu = {
        home = {
          username = "pagu";
          homeDirectory = "/home/pagu";
          stateVersion = "23.05";
        };
        xdg = lib.mkIf xdg {
          enable = true;
          userDirs = {
            enable = true;
            desktop = "\$HOME/desktop";
            documents = "\$HOME/documents";
            download = "\$HOME/downloads";
            pictures = "\$HOME/pictures";
            videos = "\$HOME/pictures/videos";
          };
          desktopEntries = let
            no = {noDisplay = true;};
          in {
            Alacritty = no // {name = "alacritty";};
            nvim = no // {name = "Neovim Wrapper";};
          };
        };
      };
    };
  };
}
