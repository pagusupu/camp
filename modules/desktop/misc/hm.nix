{
  config,
  lib,
  inputs,
  pkgs,
  ...
}: {
  imports = [inputs.home-manager.nixosModules.home-manager];
  options.cute.desktop.misc.hm.enable = lib.mkEnableOption "";
  config = lib.mkIf config.cute.desktop.misc.hm.enable {
    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;
      extraSpecialArgs = {inherit inputs;};
      users.pagu = {
        home = {
          username = "pagu";
          homeDirectory = "/home/pagu";
          packages = with pkgs; [
            localsend
            sublime-music
            vesktop
            xfce.thunar
          ];
          sessionVariables = {
            EDITOR = "nvim";
            MOZ_ENABLE_WAYLAND = 1;
            NIXOS_OZONE_WL = 1;
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
  };
}
