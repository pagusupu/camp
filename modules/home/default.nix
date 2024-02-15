{
  config,
  lib,
  inputs,
  pkgs,
  ...
}: {
  imports = [inputs.home-manager.nixosModules.home-manager];
  options.cute.home = {
    enable = lib.mkEnableOption "";
    git = lib.mkEnableOption "";
    eww = lib.mkEnableOption "";
  };
  config = let
    inherit (config.cute.home) enable eww;
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
          packages = with pkgs; [
            jq
            socat
          ];
        };
        programs.eww = lib.mkIf eww {
          enable = true;
          package = pkgs.eww-wayland;
          configDir = ./eww;
        };
      };
    };
  };
}
